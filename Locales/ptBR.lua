if not(GetLocale() == "ptBR") then
  return
end
local addonName, MDT = ...
local L = MDT.L
L = L or {}

-- MDT
L[" >Battle for Azeroth"] = ">Battle for Azeroth"
L[" >Legion"] = ">Legion"
L["%s HP"] = "%s HP"
L["%s is in sublevel: %s"] = "%s está no subnível: %s"
L["(G %d)"] = "(G %d)"
L["*Live*"] = "*Live*"
L["+ Add pull"] = "+ Adicionar pull"
L["4.RF-4.RF"] = "4.RF-4.RF"
L["Aberration"] = "Aberração"
L["Abyss Dweller"] = "Habitante do Abismo"
L["Abyssal Cultist"] = "Sectário Abissal"
L["Abyssal Eel"] = "Enguia Abissal"
L["Adderis"] = "Vipperis"
L["Addled Thug"] = "Bandido Atrapalhado"
L["Advent Nevermore"] = "Advêntia Nuncamais"
L["Aerial Unit R-21/X"] = "Unidade Aérea R-21/X"
L["Affected by:"] = "Afetado por"
L["Affixes"] = "Afixos"
L["Agitated Nimbus"] = "Nímbus Agitado"
L["Aka'ali the Conqueror"] = "Aka'ali, a Conquistadora"
L["Alarm-o-Bot"] = "Alarmobô"
L["Amarth"] = "Amarth"
L["Ancient Captain"] = "Capitão Ancestral"
L["Animated Droplet"] = "Gotícula Animada"
L["Animated Guardian"] = "Guardião Animado"
L["Animated Weapon"] = "Arma Animada"
L["Anodized Coilbearer"] = "Porta-bobina Anodizado"
L["Apply to preset"] = "Aplicar à rota"
L["Aqu'sirr"] = "Aqu'sirr"
L["Arcane Eye"] = "Olho Arcano"
--[[Translation missing --]]
--[[ L["Ardenweald"] = ""--]] 
L["Ashvane Cannoneer"] = "Canhoneiro Grimpagris"
L["Ashvane Commander"] = "Comandante Grimpagris"
L["Ashvane Deckhand"] = "Marujo Grimpagris"
L["Ashvane Destroyer"] = "Destruidor Grimpagris"
L["Ashvane Flamecaster"] = "Lança-chamas Grimpagris"
L["Ashvane Invader"] = "Invasor Grimpagris"
L["Ashvane Jailer"] = "Carcereiro Grimpagris"
L["Ashvane Marine"] = "Fuzileiro Grimpagris"
L["Ashvane Officer"] = "Oficial Grimpagris"
L["Ashvane Priest"] = "Sacerdotisa Grimpagris"
L["Ashvane Sniper"] = "Francoatirador Grimpagris"
L["Ashvane Spotter"] = "Avistador Grimpagris"
L["Ashvane Warden"] = "Guardião Grimpagris"
L["Aspix"] = "Jararax"
L["Asset Manager"] = "Gerente de Ativos"
L["Astronos"] = "Astronos"
L["Atal'ai Deathwalker"] = "Mortívago Atal'ai"
L["Atal'ai Devoted"] = "Devoto Atal'ai"
L["Atal'ai High Priest"] = "Sumo Sacerdote Atal'ai"
L["Atal'ai Hoodoo Hexxer"] = "Mandingueiro Azarento Atal'ai"
L["Atal'Dazar"] = "Atal'Dazar"
L["Atal'Dazar Sublevel"] = "Atal'Dazar Subnível "
L["atalTeemingNote"] = "Nota da Apinhada: %s%sG29 não está sempre presente. %s Os inimigos da Apinhada no G2 nem sempre estão presentes. %sG27 não está sempre presente."
L["Atrium of Sethraliss"] = "Átrio de Sethraliss"
L["Automatic Coloring"] = "Coloração Automática"
L["Automatically color pulls"] = "Colorir Automaticamente os pulls"
L["Avatar of Sethraliss"] = "Avatar de Sethraliss"
L["Awakened"] = "Desperto"
L["Awakened A"] = "Desperto A"
L["Awakened B"] = "Desperto B"
L["Azerite Extractor"] = "Extrator de Azerita"
L["Azerokk"] = "Azerokk"
L["Azules"] = "Azúles"
L["Banish"] = "Banir"
L["Banquet Steward"] = "Senescal do Banquete"
--[[Translation missing --]]
--[[ L["Battle for Azeroth"] = ""--]] 
L["Battlefield Ritualist"] = "Ritualista do Campo de Batalha"
L["Beast"] = "Besta"
L["Befouled Spirit"] = "Espírito Conspurcado"
L["Beguiling"] = "Encantadora "
L["Beguiling 1 Void"] = "Encantadora 1 Caos"
L["Beguiling 2 Tides"] = "Encantada 2 Marés"
L["Beguiling 3 Ench."] = "Encantada 3 Encantada"
L["Bewitched Captain"] = "Capitão Encantado"
L["Big Money Crab"] = "Caranguejão Ostentação"
L["Bilge Rat Brinescale"] = "Escamoura Rato de Porão"
L["Bilge Rat Buccaneer"] = "Bucaneiro Rato de Porão"
L["Bilge Rat Cutthroat"] = "Degolador Rato de Porão"
L["Bilge Rat Demolisher"] = "Demolidor Rato de Porão"
L["Bilge Rat Looter"] = "Saqueador Rato de Porão"
L["Bilge Rat Padfoot"] = "Patatenra Rato de Porão"
L["Bilge Rat Pillager"] = "Pilhador Rato de Porão"
L["Bilge Rat Seaspeaker"] = "Falamares Rato de Porão"
L["Bilge Rat Swabby"] = "Grumete Rato de Porão"
L["Bilge Rat Tempest"] = "Trovoeiro Rato de Porão"
L["Bilge Rats"] = "Ratos do Porão"
L["Black and Yellow"] = "Preto e Amarelo"
L["Black Rook Hold"] = "Castelo Corvo Negro"
L["Blacktar Bomber"] = "Bombardeiro Pichenegro"
L["Blacktooth"] = "Brigões Dentenegro"
L["Blacktooth Arsonist"] = "Incendiário Dentenegro"
L["Blacktooth Brute"] = "Brutamontes Dentenegro"
L["Blacktooth Knuckleduster"] = "Rúfio Dentenegro"
L["Blacktooth Scrapper"] = "Arruaceiro Dentenegro"
L["Bladebeak Hatchling"] = "Bicossabrinho"
L["Bladebeak Matriarch"] = "Matriarca Bicossabre"
L["Blastatron X-80"] = "Devastatrônico X-80"
L["Blight Bag"] = "Bolsa de Pragas"
L["Blight Toad"] = "Sapo Empesteado"
L["Blightbone"] = "Pragosso"
L["Blighted Sludge-Spewer"] = "Cospe-lodo Empesteado"
L["Blighted Spinebreaker"] = "Quebra-espinhas Pestilento"
L["Block Warden"] = "Carcereiro do Pavilhão"
L["Blood of the Corruptor"] = "Sangue do Corruptor"
L["Bloodsworn Agent"] = "Agente Jurassangue"
L["Bloodsworn Defiler"] = "Corruptor Jurassangue"
L["Bolstering"] = "Encorajadora"
L["Bomb Tonk"] = "Tonque Bomba"
L["Bone Magus"] = "Magus Ósseo"
L["Bottom Feeder"] = "Alimentador de Baixo"
L["Brittlebone Crossbowman"] = "Besteiro Ossofraco"
L["Brittlebone Mage"] = "Mago Ossofraco"
L["Brittlebone Warrior"] = "Guerreiro Ossofraco"
L["Brood Ambusher"] = "Emboscadora da Ninhada"
L["Brood Assassin"] = "Assassino da Ninhada"
L["Brother Ironhull"] = "Irmão Cascoférreo"
L["Brush Size"] = "Tamanho do pincel"
L["Brutal Spire of Ny'alotha"] = "Pináculo Brutal de Ny'alotha"
L["Bursting"] = "Estilhaçante"
L["Cancel"] = "Cancelar"
L["CannonNote"] = [=[Canhão Pesado%sUsável pelos jogadores%s Danifica inimigos e aliados
]=]
L["Cannot create preset '%s'"] = "Não é possível criar a rota '% s'"
L["Cannot rename preset to '%s'"] = "Não é possível renomear a rota para '% s'"
L["Captain Eudora"] = "Capitã Eudora"
L["Captain Jolly"] = "Capitão Bravata"
L["Captain Raoul"] = "Capitão Raul"
L["Carrion Worm"] = "Verme Carniceiro"
L["Catacombs"] = "Catacumbas"
L["Cathedral of Eternal Night"] = "Catedral da Noite Eterna"
L["Chamber Sentinel"] = "Sentinela da Câmara"
L["Charged Dust Devil"] = "Redemoinho de Poeira Carregado"
L["Choose Enemy Forces Format"] = "Escolha o formato das forças inimigas"
L["Choose Enemy Style. Requires Reload"] = "Escolha estilo inimigo. Requer Recarregamento "
L["Choose NPC tooltip position"] = "Escolha a posição da dica de ferramenta de NPC"
L["Choose number of colors"] = "Escolhe número de cores"
L["Choose preferred color palette"] = "Escolhe a paleta de cores preferida"
L["Chopper Redhook"] = "Gancho Estraçalho"
L["Chosen Blood Matron"] = "Máter Sangrenta Escolhida"
L["Click the fullscreen button for a maximized view of MDT."] = "Clique no botão de tela cheia para obter uma visualização maximizada do MDT"
L["Click to adjust color settings"] = "Clique para ajustar as configurações de cores"
L["Click to go to %s"] = "Clique para ir à %s"
L["Click to set dungeon level to 10"] = "Clique para definir o nível da masmorra para 10"
L["Click to switch to current week"] = "Clique para mudar para a semana atual"
L["Click to toggle AddOn Window"] = "Clique para alternar na Janela AddOn"
L["Clicking this button will attempt to join the ongoing Live Session of your group or create a new one if none is found"] = "Clicar neste botão tentará ingressar você na sessão ao vivo em andamento do seu grupo ou criar uma nova se nenhuma for encontrada."
L["Coin-Operated Crowd Pummeler"] = "Espanca-gente de Ficha"
L["Color Blind Friendly"] = "Amigável à Daltonismo"
L["Colorpicker"] = "Escolhedor de cores"
L["Colossal Tentacle"] = "Tentáculo Colossal"
L["Congealed Slime"] = "Visgo Coagulado"
--[[Translation missing --]]
--[[ L["ConnectedTip"] = ""--]] 
L["Control Undead"] = "Controlar Mortos-vivos"
L["Copy"] = "Copiar"
L["Corpse Collector"] = "Coletor de Cadáveres"
L["Corpse Harvester"] = "Cata-cadáver"
L["Court of Stars"] = [=[Pátio das Estrelas 
]=]
L["Court of Stars Sublevel"] = [=[Pátio das Estrelas
]=]
L["Coven Diviner"] = "Vaticinadora do Conventículo"
L["Coven Thornshaper"] = "Molda-espinho do Conventículo"
L["Cragmaw the Infested"] = "Goela-de-pedra, o Infestado"
L["Crawler Mine"] = "Mina Rastejante"
L["Crazed Incubator"] = "Incubador Enlouquecido"
L["Crazed Marksman"] = "Atirador Perito Enlouquecido"
L["Create"] = "Criar"
L["Create a new preset"] = "Criar uma nova rota"
L["Creepy Crawler"] = "Rastejante Sinistro"
L["Critter"] = "Bicho"
L["Cursed Spire of Ny'alotha"] = "Pináculo Amaldiçoado de Ny'alotha"
L["Custom"] = "Personalizado"
L["Custom Color Palette"] = "Paleta de cores personalizada"
L["Cutwater"] = "Corta-água"
L["Cutwater Duelist"] = "Duelista Corta-água"
L["Cutwater Harpooner"] = "Arpoador Corta-água"
L["Cutwater Knife Juggler"] = "Malabarista de Facas Corta-água"
L["Cutwater Striker"] = "Combatente Corta-água"
L["Dark Acolyte"] = "Acólita Sombria"
L["Darkheart Thicket"] = [=[Bosque Corenegro 
]=]
L["Darkheart Thicket Sublevel"] = [=[Bosque Corenegro Subnível 1
]=]
L["Dazar'ai Augur"] = "Áugure Dazar'ai"
L["Dazar'ai Colossus"] = "Colosso Dazar'ai"
L["Dazar'ai Confessor"] = "Confessor Dazar'ai"
L["Dazar'ai Honor Guard"] = "Guarda de Honra Dazar'ai"
L["Dazar'ai Juggernaut"] = "Jaganata Dazar'ai"
--[[Translation missing --]]
--[[ L["De Other Side"] = ""--]] 
L["Dealer Xy'exa"] = "Mercadora Xy'exa"
L["Death Speaker"] = "Morta-voz"
L["Decaying Flesh Giant"] = "Gigante de Carne em Decomposição"
L["Decrease Brush Size"] = "Diminuir tamanho de pincel"
L["Deepsea Ritualist"] = "Ritualista Abissal"
L["defaultPresetName"] = "Nome de rota padrão"
L["Defender of Many Eyes"] = "Defensora de Muitos Olhos"
L["Defense Bot Mk I"] = "Defensor Robótico V.I"
L["Defense Bot Mk III"] = "Defensor Robótico V.III"
L["Defiled Spire of Ny'alotha"] = "Pináculo Profanado de Ny'alotha"
L["Defunct Dental Drill"] = "Broca Dental Defunta"
L["Delete"] = "Excluir"
L["Delete %s?"] = "Excluir %s?"
L["Delete ALL drawings"] = "Excluir TODOS os desenhos"
L["Delete ALL presets"] = "Excluir TODAS as rotas"
L["Delete Preset"] = "Excluir Rota"
L["Delete this preset"] = "Excluir esta rota"
L["deleteAllDrawingsPrompt"] = "Você deseja excluir TODOS os desenhos da rota atual? %s Isso não poderá ser desfeito %s%s"
L["deleteAllWarning"] = "!!AVISO!!%s Você deseja excluir TODAS as rotas para esta masmorra? %s Você está prestes a excluir %s rota(s) %s Isto não poderá ser desfeito."
L["Demolishing Terror"] = "Terror Demolidor"
L["Demon"] = "Demônio"
L["Depraved Collector"] = "Coletor Depravado"
L["Depraved Darkblade"] = "Laminegra Depravada"
L["Depraved Houndmaster"] = "Mestre de Matilha Depravado"
L["Depraved Obliterator"] = "Obliterador Depravado"
L["Depths Warden"] = "Guardião das Profundezas"
L["Despondent Scallywag"] = "Cão Sarnento Jururu"
L["Dessia the Decapitator"] = "Déssia, a Decapitadora"
L["Detention Block"] = "Bloco de detenção"
L["Devos"] = "Devos"
L["Devouring Maggot"] = "Verme Devorador"
L["Devout Blood Priest"] = "Sacerdotisa Sangrenta Devota"
L["Dinomancer Kish'o"] = "Dinomante Kish'o"
L["Diseased Horror"] = "Horror Doentio"
L["Diseased Lasher"] = "Açoitadora Doente"
L["Diseased Mastiff"] = "Mastim Doente"
L["Disgusting Refuse"] = "Refugo Asqueroso"
L["Disorient"] = "Desorientar"
L["Dockhound Packmaster"] = "Caravaneiro Cão das Docas"
L["Doctor Ickus"] = "Doutor Nojus"
L["Does not delete your drawings"] = "Não irá excluir seus desenhos"
L["Dokigg the Brutalizer"] = "Dokigg, o Brutalizador"
L["Domina Venomblade"] = "Dômina Lâmina Venenosa"
L["Drag the bottom right edge to resize MDT."] = "Arraste a borda inferior direita para redimensionar o MDT"
L["Dragonkin"] = "Dragonídeo"
L["Drawing: Arrow"] = "Desenhar: flecha"
L["Drawing: Eraser"] = "Desenhar: apagador"
L["Drawing: Freehand"] = "Desenhar: à mão livre"
L["Drawing: Line"] = "Desenhar: linha"
L["Dread Captain Lockwood"] = "Terrível Capitã Madeira"
L["Dreadful Huntmaster"] = "Mestre da Caça Medonho"
L["Dreadwing Raven"] = "Corvo Terrorasa"
L["Dredged Sailor"] = "Marinheiro Dragado"
L["Droman Oulfarran"] = "Droman Oulfarran"
L["Drowned Depthbringer"] = "Arauto das Profundezas Afogado"
L["Drust Boughbreaker"] = "Quebrarramo Drusto"
L["Drust Harvester"] = "Ceifador Drusto"
L["Drust Soulcleaver"] = "Rachalma Drusto"
L["Drust Spiteclaw"] = "Garramal Drusto"
L["Dungeon Level"] = "Nível da masmorra"
L["Earlier Version"] = "Você possuí uma versão antiga da rota com o nome '%s'%s Você deseja atualizar ou criar uma nova copia? %s%s%s"
L["Earthrager"] = "Furitérreo"
L["Echelon"] = "Escalon"
L["Edit"] = "Editar"
L["Elder Leaxa"] = "Anciã Leaxa"
L["Elemental"] = "Elemental"
L["Embalming Fluid"] = "Fluido Embalsamador"
L["Emissary of the Tides"] = "Emissária das Marés"
L["Enable Minimap Button"] = "Habilitar botão do minimapa"
L["Enchanted Emissary"] = "Emissária Encantada"
L["Enemies related to seasonal affixes are currently hidden"] = "Inimigos relacionados ao afixo de temporada estão atualmente escondidos"
L["Enemy Info"] = "Informação de Inimigos"
L["Enemy Info NPC Creature Type"] = "Informação de Inimigo PNJ Tipo de criatura "
L["Enemy Info NPC Enemy Forces"] = "Informação de Inimigo PNJ Forças inimigas"
L["Enemy Info NPC Enemy Forces (Teeming)"] = "Informação de Inimigo PNJ Forças Inimigas (Apinhada)"
L["Enemy Info NPC Health"] = "Informação de Inimigo PNJ Vida (+%d %s)"
L["Enemy Info NPC Id"] = "Informação de Inimigo PNJ ID"
L["Enemy Info NPC Level"] = "Informação de Inimigo PNJ Nível"
L["Enemy Info NPC Name"] = "Informação de Inimigo PNJ Nome"
L["Enemy Info NPC Stealth"] = "Informação de Inimigo PNJ Invisível"
L["Enemy Info NPC Stealth Detect"] = "Informação de Inimigo PNJ Detecta Invisibilidade"
L["Enraged Mask"] = "Máscara Enfurecida"
L["Enraged Spirit"] = "Espírito Enfurecido"
L["Enslave Demon"] = "Aprisionar demônios"
L["Enthralled Guard"] = "Guarda Enfeitiçado"
L["Entropic Spire of Ny'alotha"] = "Pináculo Entrópico de Ny'alotha"
L["Etherdiver"] = "Mergulhador do Aéter"
L["Executor Tarvold"] = "Executor Tarvold"
L["Expand the top toolbar to gain access to drawing and note features."] = "Expanda a barra de ferramentas superior para ganhar acesso a desenhar e recursos de notas"
L["Experimental Sludge"] = "Visgo Experimental"
L["Expert Technician"] = "Técnico Especialista"
L["Explosive"] = "Explosivo"
L["Export"] = "Exportar"
L["Export the preset as a text string"] = "Exportar a rota como texto string"
L["Eye of Azshara"] = "Olho de Azshara"
L["Eye of Azshara Sublevel"] = "Olho de Azshara Subnível 1 "
L["Faceless Corruptor"] = "Corruptor Sem-rosto"
L["Faceless Maiden"] = "Donzela Sem-rosto"
L["Faithless Tender"] = "Conservador Ímpio"
L["Fallen Deathspeaker"] = "Morta-voz Caído"
L["Famished Tick"] = "Carrapato Faminto"
L["Fanatical Headhunter"] = "Caçador de Cabeças Fanático"
L["Fear"] = "Medo"
L["Feasting Skyscreamer"] = "Gritacéu Devorante"
L["Feckless Assistant"] = "Assistente Incompetente"
L["Fen Hatchling"] = "Filhote do Pântano"
L["Fen Hornet"] = "Marimbondo do Pântano"
L["Feral Bloodswarmer"] = "Enxameador Sanguíneo Feral"
L["Fetid Maggot"] = "Verme Fétido"
L["Field of the Eternal Hunt"] = "Campos da Caça Eterna"
L["Finger Food"] = "Petiscos"
L["Fleeting Manifestation"] = "Manifestação Fugaz"
L["Flesh Crafter"] = "Artesão de Carne"
--[[Translation missing --]]
--[[ L["Font of Fealty"] = ""--]] 
L["Footbomb Hooligan"] = "Badernista de Futebomba"
L["Forces"] = "Forças"
L["Forces only: 5/200"] = "Forças apenas: 5/200"
L["Forces+%: 5/200 (2.5%)"] = "Forças+%: 5/200 (2.5%)"
L["Forgotten Denizen"] = "Habitante Esquecido"
L["Forsworn Castigator"] = "Castigadora Perjura"
L["Forsworn Champion"] = "Campeão Perjuro"
L["Forsworn Goliath"] = "Golias Perjuro"
L["Forsworn Helion"] = "Infernizador Perjuro"
L["Forsworn Inquisitor"] = "Inquisidora Perjura"
L["Forsworn Justicar"] = "Justicar Perjura"
L["Forsworn Mender"] = "Reparador Perjuro"
L["Forsworn Skirmisher"] = "Escaramuçador Perjuro"
L["Forsworn Squad-Leader"] = "Líder de Esquadrão Perjuro"
L["Forsworn Stealthclaw"] = "Garrafurtiva Perjuro"
L["Forsworn Usurper"] = "Usurpador Perjuro"
L["Forsworn Vanguard"] = "Vanguarda Perjura"
L["Forsworn Warden"] = "Guardião Perjuro"
L["Fortified"] = "Fortificado"
L["frackingNote"] = "Fracking Totem %s Utilizável por jogadores%s Incapacita Furia da Terra por 1min - Quebra com dano.  "
L["Freehold"] = "Angra do Facão"
L["Freehold Barhand"] = "Garçonete de Angra do Facão"
L["Freehold Deckhand"] = "Marujo de Angra do Facão"
L["Freehold Pack Mule"] = "Mula de Carga de Angra do Facão"
L["Freehold Shipmate"] = "Tripulante de Angra do Facão"
L["Freehold Sublevel"] = "Angra do Facão Subnível 1 "
L["freeholdBeguilingPatrolNote"] = "Semana 2/5/8/11: G53 é estacionário no Emissário das Marés 13 "
L["freeholdGraveyardDescription1"] = "Desbloqueia após derrotar Capitão-do-Céu Kragg"
L["freeholdGraveyardDescription2"] = "Desbloqueia após derrotar Conselho dos Capitães"
L["Frenzied Ghoul"] = "Carniçal Frenético"
L["Fungalmancer"] = "Fungimante"
L["Fungi Stormer"] = "Estrondeador Fungal"
L["Fungret Shroomtender"] = "Cogumeleiro Fungrete"
L["G.U.A.R.D."] = "G.U.A.R.D.A."
L["Galecaller Apprentice"] = "Aprendiz de Chamaventos"
L["Galecaller Faye"] = "Chamatormenta Faia"
L["Galvazzt"] = "Galvazzt"
L["Gamesman's Hall"] = "Salão de Jogos"
--[[Translation missing --]]
--[[ L["Gardens of Repose"] = ""--]] 
L["General Kaal"] = "General Kaal"
L["Giant"] = "Gigante"
L["Gilded Priestess"] = "Sacerdotisa Dourada"
L["Globgrog"] = "Globgrog"
L["Gloom Horror"] = "Horror Melancólico"
L["Gluttonous Tick"] = "Carrapato Esfomeado"
L["Gnome-Eating Slime"] = "Lodo Devorador de Gnomos"
L["Gnomercy 4.U."] = "Gnomisericórdia"
L["Gorak Tul"] = "Gorak Tul"
L["Gorechop"] = "Estripança"
L["Goregrind"] = "Raspatripa"
L["Goregrind Bits"] = "Restos de Raspatripa"
L["Gorestained Piglet"] = "Porquinho Ensanguentado"
L["Grand Overseer"] = "Grão-feitor"
L["Grand Proctor Beryllia"] = "Grã-inspetora Berília"
L["Graveyard"] = "Cemitério"
L["Grease Bot"] = [=[Graxômato
]=]
L["Grievous"] = "Atroz"
L["Grip"] = "Garra"
L["Gripping Terror"] = "Terror Agarrante"
L["Grotesque Horror"] = "Horror Grotesco"
L["Grubby Dirtcruncher"] = "Grudinho Calcapó"
L["Guard Captain Atu"] = "Capitão da Guarda Atu"
L["Guardian Elemental"] = "Elemental Guardião"
L["Guardian's Library"] = "Biblioteca do Guardião"
L["Gunker"] = "Visgueiro"
L["Gushing Slime"] = "Visgo Esguichante"
L["Hadal Darkfathom"] = "Hadal Abismo Negro"
L["Hakkar the Soulflayer"] = "Hakkar, o Esfolador de Almas"
L["Halkias"] = "Hálkias"
L["Hall of the Moon"] = "Salão da Lua"
--[[Translation missing --]]
--[[ L["Halls of Atonement"] = ""--]] 
L["Halls of Valor"] = "Salões da Bravura"
L["Halls of Valor Sublevel"] = "Salões da Bravura Subnível"
--[[Translation missing --]]
--[[ L["HallsOfAtonementFloor1"] = ""--]] 
--[[Translation missing --]]
--[[ L["HallsOfAtonementFloor2"] = ""--]] 
--[[Translation missing --]]
--[[ L["HallsOfAtonementFloor3"] = ""--]] 
L["Harlan Sweete"] = "Arlão Mel"
L["Harugia the Bloodthirsty"] = "Harúgia, a Sedenta por Sangue"
L["Hatchling Nest"] = "Ninho de Filhotes"
L["Head Custodian Javlin"] = "Encarregado Javlin"
L["Head Machinist Sparkflux"] = "Maquinista-chefe Fluichispa"
L["Headless Client"] = "Cliente Sem Cabeça"
L["Heart Guardian"] = "Guardião de Coração"
L["Heartsbane Runeweaver"] = "Fiarruna Sangra-coração"
L["Heartsbane Soulcharmer"] = "Encantadeira Sangra-coração"
L["Heartsbane Vinetwister"] = "Cipoeira Sangra-coração"
L["Heavy Scrapbot"] = "Sucatinho Pesado"
L["Helmouth Cliffs"] = [=[Penhascos da Boca do Inferno 
]=]
L["helpPlateDungeon"] = [=[Customizar opções da masmorra
]=]
L["helpPlateDungeonSelect"] = "Selecione uma masmorra e navegue para diferentes subníveis"
L["helpPlateNPC"] = "Clique para selecionar inimigos% sCTRL-Clique para selecionar inimigos% sSHIFT-Clique para selecionar inimigos e criar um novo pull"
L["helpPlatePresets"] = "Gerenciar, compartilhar e colaborar nas rotas"
L["helpPlatePulls"] = "Crie e gerencie seus pulls% sClique com o botão direito do mouse para obter mais opções"
L["High Adjudicator Aleez"] = "Alta-adjudicadora Alee"
L["High Contrast"] = "Contraste Alto"
L["Hired Assassin"] = "Assassino de Aluguel"
L["HK-8 Aerial Oppression Unit"] = "Unidade de Opressão Aérea HK-8"
L["Hold CTRL to single-select enemies."] = "Segure CTRL para selecionar individualmente inimigos"
L["Hold SHIFT to create a new pull while selecting enemies."] = "Segure SHIFT para criar um novo pull enquanto seleciona inimigos"
L["Hold SHIFT to delete all presets with the delete preset button."] = "Segure SHIFT para deletar todas as rotas com o botão de deletar rota"
L["Honored Raptor"] = "Raptor Honrado"
--[[Translation missing --]]
--[[ L["Honor's Ascent"] = ""--]] 
L["Hoodoo Hexer"] = "Mandingueiro Azarento"
L["Humanoid"] = "Humano"
L["Ickor Bileflesh"] = "Carnebílis Línfico"
L["If the Minimap Button is enabled"] = "Se o botão do Minimapa estiver habilitado"
L["Imbued Stormcaller"] = "Tempestário Imbuído"
L["Import"] = "Importar"
L["Import a preset from a text string"] = "Importar uma rota de uma cadeia de texto"
L["Import Preset"] = "Importar Rota"
L["Imprison"] = "Aprisionar"
L["In the bottom right corner"] = "No canto inferior direito"
L["Incapacitate"] = "Incapacitar"
L["Increase Brush Size"] = "Aumentar tamanho de pincel"
L["Infected Peasant"] = "Camponês Infectado"
L["Infested"] = "Infestado"
L["Infused Quill-feather"] = "Pena de Cálamo Imbuída"
L["Ingra Maloch"] = "Ingra Maloch"
L["Inquisitor Sigar"] = "Inquisidor Sigarro"
L["Insatiable Brute"] = "Brutamontes Insaciável"
L["Insert Note"] = "Inserir Nota"
--[[Translation missing --]]
--[[ L["Inspiring"] = ""--]] 
L["Interment Construct"] = "Constructo de Inumação"
L["Invalid import string"] = "Cadeia de importação inválida"
L["Ironhull Apprentice"] = "Aprendiz Cascoférreo"
L["Irontide Bonesaw"] = "Serra-osso Maré-férrea"
L["Irontide Buccaneer"] = "Bucaneiro Maré-férrea"
L["Irontide Cleaver"] = "Cutelador Maré-férrea"
L["Irontide Corsair"] = "Corsária Maré-férrea"
L["Irontide Crackshot"] = "Tiro-certo Maré-férrea"
L["Irontide Crusher"] = "Esmagador Maré-férrea"
L["Irontide Enforcer"] = "Impositor Maré-férrea"
L["Irontide Marauder"] = "Pilhador Maré-férrea"
L["Irontide Mastiff"] = "Mastim Maré-férrea"
L["Irontide Oarsman"] = "Remador Maré-férrea"
L["Irontide Officer"] = "Oficial Maré-férrea"
L["Irontide Powdershot"] = "Tiropólvora Maré-férrea"
L["Irontide Raider"] = "Saqueador Maré-férrea"
L["Irontide Ravager"] = "Assolador Maré-férrea"
L["Irontide Stormcaller"] = "Tempestário Maré-férrea"
L["Irontide Thug"] = "Bandido Maré-férrea"
L["Irontide Waveshaper"] = "Moldaonda Maré-férrea"
L["Jagged Hound"] = "Canaz Serrilhado"
L["Jes Howlis"] = "Jesse Loupino"
L["Join"] = "Juntar-se"
L["Join Crew"] = "Juntar-se ao Grupo"
L["Join Live Session"] = "Juntar-se na sessão ao vivo:%s%s: %s - %s"
L["Junkyard D.0.G."] = "C.A.0. do Ferro-velho"
L["Juvenile Runestag"] = "Runicervo Jovem"
L["K.U.-J.0."] = "K.U.-J.0."
L["King A'akul"] = "Rei A'akul"
L["King Dazar"] = "Rei Dazar"
L["King Gobbamak"] = "Rei Gobbamak"
L["King Rahu'ai"] = "Rei Rahu'ai"
L["King Timalji"] = "Rei Timalji"
L["Kings' Rest"] = "Repouso do Rei"
L["Kings' Rest Sublevel"] = "Repouso do Rei subnível"
L["Kin-Tara"] = "Kin-Tara"
L["Klotos"] = "Klotos"
L["Knight Captain Valyri"] = "Capitã Cavaleira Valyri"
L["Knock"] = "Bater"
L["krBrutePatrolNote"] = "Este bruto vai parar de patrulhar quando chegar no Emissário das Marés 7"
L["krGraveyardNote1"] = "Desbloqueado após derrotar o Conselho das Tribos"
L["Krolusk Hatchling"] = "Crolusquinho"
L["Krolusk Pup"] = "Bebê Crolusco"
L["krSkipNote"] = [=[Guia Espiritual Imaculado%s Desbloqueado após derrotar Constructo de Purificação 1
]=]
L["Kryxis the Voracious"] = "Kryxis, o Voraz"
L["Kul Tiran Footman"] = "Soldado Raso Kultireno"
L["Kul Tiran Halberd"] = "Alabardeiro Kultireno"
L["Kul Tiran Marksman"] = "Atirador Perito Kultireno"
L["Kul Tiran Vanguard"] = "Vanguarda Kultirena"
L["Kul Tiran Wavetender"] = "Zelamar Kultireno"
L["Kula the Butcher"] = "Kula, a Açougueira"
L["Kul'tharok"] = "Kul'tharok"
L["Kyrian Dark-Praetor"] = "Pretor Negro Kyriano"
L["Kyrian Stitchwerk"] = "Suturado Kyriano"
L["Lady Waycrest"] = "Lady Capelo"
L["Lakesis"] = "Lakesis"
L["Language"] = "Idioma"
L["LargePresetWarning"] = "Você está tentando compartilhar uma rota muito grande (%d caracteres)%s Ao invés disso é recomendado usar a função de exportar e compartilhar rotas grandes através do wago.io.%s Tem certeza que quer compartilhar essa rota?%s"
--[[Translation missing --]]
--[[ L["Legion"] = ""--]] 
L["Level %d %s"] = "Nível %d %s"
L["Levels below 10 will hide enemies related to seasonal affixes"] = "Níveis abaixo de 10 ocultarão inimigos relacionados a afixos temporais."
L["Library Floor"] = "Andar da Biblioteca"
L["Link Spells"] = "Compartilhar Feitiços"
L["Live"] = "Ao vivo"
L["Live Session"] = "Transmissão ao vivo"
L["Living Current"] = "Corrente Viva"
L["Living Rot"] = "Putrefação Viva"
L["Living Waste"] = "Dejeto Vivo"
L["Local color blind mode"] = [=[Modo daltônico local
]=]
L["Locked"] = "Trancado"
L["Lord Chamberlain"] = "Lorde Camarista"
L["Lord Ravencrest's Chamber"] = "Câmara do Senhor Cristacorvo"
L["Lord Stormsong"] = "Lorde Trovamare"
L["Lord Waycrest"] = "Lorde Capelo"
L["Lost Soul"] = "Alma Perdida"
L["Lower Broken Stair"] = "Escada Inferior Quebrada"
L["Loyal Creation"] = "Criação Leal"
L["Loyal Stoneborn"] = "Litonato Leal"
L["Lubricator"] = "Lubrificador"
L["Ludwig Von Tortollan"] = "Ludovico Von Tortollano"
L["Maddened Survivalist"] = "Sobrevivencialista Louco"
L["MaggotNote"] = [=[Nota para Verme Devorador:%s%s Vermes Devoradores com o buff 'Parasita' vai tentar 'Infestar' Jogadores.%s Após lançar com sucesso o feitiço 'Infestar' o Verme Devorador vai desaparecer e gerar 2x Vermes Devoradores após um debuff no jogador infestado acabar. %s Você só pode ganhar 1 contagem por matar o Verme Devorador inicial - Os dois Vermes Devoradores gerados recentemente não irão contar. %s% Camponeses Infectados geram 3x Vermes Devoradores onde cada um conta. %s Estes Vermes Devoradores são mapeados ao lado dos Camponeses Infectados 

]=]
L["Make this preset the live preset"] = "Tornar essa rota a rota ao vivo"
L["Malfunctioning Scrapbot"] = "Sucatinho Defeituoso"
L["Malignant Spawn"] = "Cria Maligna"
L["Maniacal Soulbinder"] = "Vinculador de Almas Maníaco"
L["Manifestation of Envy"] = "Manifestação de Inveja"
L["Margrave Stradama"] = "Margrave Stradama"
L["Marked Sister"] = "Irmã Marcada"
L["Master's Terrace"] = "Terraço do Mestre"
L["Matron Alma"] = "Máter Alma"
L["Matron Bryndle"] = "Máter Brinda"
L["Mature Krolusk"] = "Crolusco Adulto"
L["Maw of Souls"] = "Gorja das Almas"
L["Mchimba the Embalmer"] = "Muquimba, o Embalsamador"
L["MDI Mode"] = "Modo MDI"
L["MDT: Error importing preset"] = "MDT: Erro importando rota"
L["MDT: Spells for %s:"] = "MDT: Feitiços para %s:"
L["Mech Jockey"] = "Jóquei Mecanoide"
--[[Translation missing --]]
--[[ L["Mechagon"] = ""--]] 
L["Mechagon - Junkyard"] = "Gnomecan - Ferro-velho"
L["Mechagon - Workshop"] = "Gnomecan - Oficina"
L["Mechagon Cavalry"] = "Cavaleiro de Gnomecan"
L["Mechagon Citizen"] = "Cidadão de Gnomecan"
L["Mechagon City"] = "Gnomecan"
L["Mechagon Island"] = "Ilha de Gnomecan"
L["Mechagon Island (Tunnels)"] = "Ilha de Gnomecan (Túneis) "
L["Mechagon Mechanic"] = "Mecânico de Gnomecan"
L["Mechagon Prowler"] = "Predadora de Gnomecan"
L["Mechagon Renormalizer"] = "Renormalizadora de Gnomecan"
L["Mechagon Tinkerer"] = "Engenhoqueira de Gnomecan"
L["Mechagon Trooper"] = "Soldado de Gnomecan"
L["Mechanical"] = "Mecânico"
L["Mechanized Peacekeeper"] = "Pacificador Mecanizado"
L["Merektha"] = "Merektha"
L["Millhouse Manastorm"] = "Millhouse Manavento"
L["Millificent Manastorm"] = "Milévola Manavento"
L["Mind Control"] = "Controle Mental"
L["Mine Rat"] = "Rato da Mina"
L["minecartNote"] = "Vagonete%sUsável por jogadores"
L["Minion of Zul"] = "Lacaio de Zul"
L["Mire Soldier"] = "Soldado do Charco"
L["Mistcaller"] = "Chamabruma"
--[[Translation missing --]]
--[[ L["Mists of Tirna Scithe"] = ""--]] 
L["Mistveil Defender"] = "Defensora do Véu da Névoa"
L["Mistveil Gorgegullet"] = "Devoragorja do Véu da Névoa"
L["Mistveil Guardian"] = "Guardião do Véu da Névoa"
L["Mistveil Matriarch"] = "Matriarca do Véu da Névoa"
L["Mistveil Nightblossom"] = "Flor-da-noite do Véu da Névoa"
L["Mistveil Shaper"] = "Moldador do Véu da Névoa"
L["Mistveil Stalker"] = "Caçador do Véu da Névoa"
L["Mistveil Stinger"] = "Aguilhante do Véu da Névoa"
L["Mistveil Tender"] = "Conservadora do Véu da Névoa"
L["mlGraveyardNote1"] = [=[Desbloqueia após derrotar Espanca-gente de Ficha
]=]
L["mlGraveyardNote2"] = "Desbloqueia após chegar no fim do passeio de vagonete"
L["mlGraveyardNote3"] = "Desbloqueia após derrotar Rixxa Fazfaísca"
L["mlJockeyNote"] = "Jóquei Mecanoide 21 e 22 precisam estar marcados no momento em que seus Pacificadores são destruídos"
L["Mogul Razdunk"] = "Dalberto Frustrus"
L["Monzumi"] = "Monzumi"
L["Mordretha, the Endless Empress"] = "Mordretha, a Imperatriz Infinda"
L["Mouseover a patrolling enemy with a blue border to view the patrol path."] = "Passe o mouse sobre um inimigo patrulhando com uma borda azul para ver o caminho da patrulha."
L["Mouseover the Live button while in a group to learn more about Live mode."] = "Passe o mouse sobre o botão Ao vivo enquanto estiver em um grupo para saber mais sobre o modo Ao vivo."
L["Move Object"] = "Mover Objeto"
L["Mueh'zala"] = "Mueh'zala"
L["Mythresh, Sky's Talons"] = "Mythresh, as Garras do Céu"
L["Naeno Megacrash"] = "Neno Pechadas"
L["Nalthor the Rimebinder"] = "Nalthor, o Senhor da Geada"
L["Nar'zudah"] = "Nar'zudah"
L["Necrotic"] = "Necrótica"
L["Nefarious Darkspeaker"] = "Orador Sombrio Nefasto"
L["Neltharion's Lair"] = [=[Covil de Neltharian 
]=]
L["Neltharion's Lair Sublevel"] = [=[Covil de Neltharian Subnível 1
 ]=]
L["Netherspace"] = "Eterespaço"
L["New"] = "Novo"
L["New NPC at Cursor Position"] = [=[Novo NPC na posição do cursor
]=]
L["New Patrol Waypoint at Cursor Position"] = "Novo Waypoint de Patrulha na Posição do Cursor"
L["New Preset"] = "Nova Rota"
L["Next to the NPC"] = "Próximo ao NPC"
L["Noble Skirmisher"] = "Escaramuçador Nobre"
L["Not specified"] = "Não Especificado "
L["Note Text:"] = "Nota de texto"
L["Off-Duty Laborer"] = "Operário de Folga"
L["Officer Quarters"] = "Ala dos Oficiais"
L["Omega Buster"] = "Detonador Ômega"
L["Oozing Leftovers"] = "Restos Gosmentos"
L["Open MDI override options"] = "Abrir opções de substituição do MDI"
L["Opera Hall Balcony"] = "Sacada do Salão de Ópera"
L["Oppressive Banner"] = "Estandarte Opressor"
L["Ordnance Specialist"] = "Especialista em Explosivos"
L["Oryphrion"] = "Orifriona"
L["Ossified Conscript"] = "Conscrito Ossificado"
L["Overflowing"] = [=[Transbordante 
]=]
L["Overseer Korgus"] = "Feitor Korgus"
L["Overseer's Redoubt"] = "Reduto do Feitor"
L["Overseer's Summit"] = " Torre do Feitor"
L["Paceran the Virulent"] = "Paceram, o Virulento"
L["Pallid Gorger"] = "Devorador Pálido"
L["Patchwerk Soldier"] = "Soldado Retalhoso"
L["Path of Illumination"] = "Caminho da Iluminação"
L["Pestilence Slime"] = "Visgo da Pestilência"
L["Pestilent Harvester"] = "Ceifador Pestilento"
L["Pistonhead Blaster"] = "Bombarda Cabeça-de-pistão"
L["Pistonhead Mechanic"] = "Mecânico Cabeça-de-pistão"
L["Pistonhead Scrapper"] = "Desmanchadora Cabeça-de-pistão"
L["Plague Bomb"] = "Bomba Pestilenta"
L["Plague Doctor"] = "Médica da Peste"
L["Plaguebelcher"] = "Pestarroto"
L["Plaguebinder"] = "Atapeste"
L["Plagueborer"] = "Furapeste"
L["Plaguebound"] = "Pestífero"
L["Plaguebound Devoted"] = "Devota Pestilenta"
L["Plaguebound Fallen"] = "Decaída Pestífera"
--[[Translation missing --]]
--[[ L["Plaguefall"] = ""--]] 
--[[Translation missing --]]
--[[ L["plaguefallDevotedNote"] = ""--]] 
L["Plagueroc"] = "Roca-da-peste"
--[[Translation missing --]]
--[[ L["Plain Texture"] = ""--]] 
--[[Translation missing --]]
--[[ L["Players can join the live session by either clicking this button or the Live Session chat link"] = ""--]] 
--[[Translation missing --]]
--[[ L["Please report any bugs on https://github.com/Nnoggie/MythicDungeonTools/issues"] = ""--]] 
L["Polymorph"] = "Polimorfia"
L["Portal Guardian"] = "Guardião de Portal"
--[[Translation missing --]]
--[[ L["Portrait"] = ""--]] 
L["Posh Vacationer"] = "Turista Elegante"
--[[Translation missing --]]
--[[ L["Preset '%s' already exists"] = ""--]] 
--[[Translation missing --]]
--[[ L["Preset Export"] = ""--]] 
--[[Translation missing --]]
--[[ L["Preset Name"] = ""--]] 
--[[Translation missing --]]
--[[ L["Prideful"] = ""--]] 
L["Priestess Alun'za"] = "Sacerdotisa Alun'za"
--[[Translation missing --]]
--[[ L["Prison Bars"] = ""--]] 
--[[Translation missing --]]
--[[ L["Prison Gate"] = ""--]] 
--[[Translation missing --]]
--[[ L["Pull Drop Clear Pull"] = ""--]] 
--[[Translation missing --]]
--[[ L["Pull Drop Close"] = ""--]] 
--[[Translation missing --]]
--[[ L["Pull Drop Color"] = ""--]] 
--[[Translation missing --]]
--[[ L["Pull Drop Color Settings"] = ""--]] 
--[[Translation missing --]]
--[[ L["Pull Drop Colorize Preset"] = ""--]] 
--[[Translation missing --]]
--[[ L["Pull Drop Delete"] = ""--]] 
--[[Translation missing --]]
--[[ L["Pull Drop Insert after"] = ""--]] 
--[[Translation missing --]]
--[[ L["Pull Drop Insert before"] = ""--]] 
--[[Translation missing --]]
--[[ L["Pull Drop Merge"] = ""--]] 
--[[Translation missing --]]
--[[ L["Pull Drop Merge down"] = ""--]] 
--[[Translation missing --]]
--[[ L["Pull Drop Merge up"] = ""--]] 
--[[Translation missing --]]
--[[ L["Pull Drop Move down"] = ""--]] 
--[[Translation missing --]]
--[[ L["Pull Drop Move up"] = ""--]] 
--[[Translation missing --]]
--[[ L["Pull Drop Reset Color"] = ""--]] 
--[[Translation missing --]]
--[[ L["Pull Drop Reset Preset"] = ""--]] 
L["Purification Construct"] = "Constructo de Purificação"
L["Putrid Butcher"] = "Açougueiro Pútrido"
L["Quaking"] = "Estremecedora"
L["Queen Patlaa"] = "Rainha Patlaa"
L["Queen Wasi"] = "Rainha Wasi"
L["Raal the Gluttonous"] = "Raal, o Glutonoso"
L["Raging"] = "Enraivecedora"
L["Raging Bloodhorn"] = "Sangaste Enfurecido"
--[[Translation missing --]]
--[[ L["Rainbow"] = ""--]] 
L["Rancid Gasbag"] = "Gasoso Repugnante"
L["Ravenous Dreadbat"] = "Deimorcego Voraz"
--[[Translation missing --]]
--[[ L["Ravenshold"] = ""--]] 
L["Reanimated Crossbowman"] = "Besteiro Reanimado"
L["Reanimated Guardian"] = "Guardião Reanimado"
L["Reanimated Honor Guard"] = "Guarda de Honra Reanimado"
L["Reanimated Mage"] = "Mago Reanimado"
L["Reanimated Warrior"] = "Guerreiro Reanimado"
L["Reanimation Totem"] = "Totem de Reanimação"
L["Reaping"] = "Ceifadora"
--[[Translation missing --]]
--[[ L["receiveErrorUpdate"] = ""--]] 
--[[Translation missing --]]
--[[ L["Receiving: ..."] = ""--]] 
--[[Translation missing --]]
--[[ L["Red, Green and Blue"] = ""--]] 
--[[Translation missing --]]
--[[ L["Redo"] = ""--]] 
L["Refreshment Vendor"] = "Vendedora de Refeições"
L["Regal Mistdancer"] = "Dançarino da Névoa Régio"
--[[Translation missing --]]
--[[ L["Relentless"] = ""--]] 
L["Remnant of Fury"] = "Resquício da Fúria"
--[[Translation missing --]]
--[[ L["Rename"] = ""--]] 
--[[Translation missing --]]
--[[ L["Rename Preset"] = ""--]] 
--[[Translation missing --]]
--[[ L["Rename the preset"] = ""--]] 
L["Repentance"] = "Contrição"
L["Research Scribe"] = "Escriba Pesquisadora"
--[[Translation missing --]]
--[[ L["Reset"] = ""--]] 
--[[Translation missing --]]
--[[ L["Reset %s?"] = ""--]] 
--[[Translation missing --]]
--[[ L["Reset Preset"] = ""--]] 
--[[Translation missing --]]
--[[ L["Reset the preset to the default state"] = ""--]] 
--[[Translation missing --]]
--[[ L["Return to Karazhan Lower"] = ""--]] 
--[[Translation missing --]]
--[[ L["Return to Karazhan Upper"] = ""--]] 
--[[Translation missing --]]
--[[ L["Return to the live preset"] = ""--]] 
L["Rezan"] = "Rezan"
L["Rigged Plagueborer"] = "Furapeste Armado"
--[[Translation missing --]]
--[[ L["Right click a pull for more options."] = ""--]] 
--[[Translation missing --]]
--[[ L["Right click an enemy to open the enemy info window."] = ""--]] 
--[[Translation missing --]]
--[[ L["Right click for more info"] = ""--]] 
--[[Translation missing --]]
--[[ L["Right-click to lock Minimap Button"] = ""--]] 
--[[Translation missing --]]
--[[ L["Right-Click to reset NPC position"] = ""--]] 
L["Riptide Shredder"] = "Retalhador Contracorrente"
L["Risen Bonesoldier"] = "Soldado-de-osso Reanimado"
L["Risen Cultist"] = "Sectário Reanimado"
L["Risen Soul"] = "Alma Reanimada"
L["Risen Warlord"] = "Senhor da Guerra Erguido"
L["Rixxa Fluxflame"] = "Rixxa Fazfaísca"
L["Rockbound Sprite"] = "Duende Rochatado"
L["Rocket Tonk"] = "Tonque Foguete"
L["Root"] = "Enraizar"
--[[Translation missing --]]
--[[ L["Rotation"] = ""--]] 
L["Rotmarrow Slime"] = "Visgo Putrilinfa"
L["Rotspew"] = "Cuspepodre"
L["Rotspew Leftovers"] = "Sobras de Cuspepodre"
L["Rotting Slimeclaw"] = "Garragosma Putrescente"
L["Rowdy Reveler"] = "Foliã Irritada"
--[[Translation missing --]]
--[[ L["Ruin's Descent"] = ""--]] 
L["Runecarver Sorn"] = "Entalhador de Runas Sorn"
L["Runestag Elderhorn"] = "Runicervo Chifrancião"
L["Runic Disciple"] = "Discípula Rúnica"
--[[Translation missing --]]
--[[ L["Sacrificial Pits"] = ""--]] 
--[[Translation missing --]]
--[[ L["Sacristy of Elune"] = ""--]] 
L["Safety Shark"] = "Tubarão de Segurança"
L["Saltwater Snapper"] = "Tartalisca de Água Salgada"
L["Samh'rek, Beckoner of Chaos"] = "Samh'rek, Convocador do Caos"
L["Sand-Crusted Striker"] = "Golpeador Crostareia"
L["Sandfury Stonefist"] = "Punhopétreo Zangareia"
L["Sandswept Marksman"] = "Atirador Perito Areeiro"
--[[Translation missing --]]
--[[ L["Sanguine"] = ""--]] 
L["Sanguine Cadet"] = "Cadete Sanguíneo"
--[[Translation missing --]]
--[[ L["Sanguine Depths"] = ""--]] 
--[[Translation missing --]]
--[[ L["Sanguine DepthsFloor1"] = ""--]] 
--[[Translation missing --]]
--[[ L["Sanguine DepthsFloor2"] = ""--]] 
L["Sap"] = "Aturdir"
L["Sathel the Accursed"] = "Sathel, o Amaldiçoado"
L["Saurolisk Bonenipper"] = "Saurolisco Mordiscosso"
L["Scaled Krolusk Rider"] = "Cavalgante de Crolusco Escamado"
L["Scaled Krolusk Tamer"] = "Domador de Crolusco Escamado"
L["Scrapbone Bully"] = "Valentão Sucatosso"
L["Scrapbone Grinder"] = "Triturador Sucatosso"
L["Scrapbone Grunter"] = "Roncador Sucatosso"
L["Scrapbone Shaman"] = "Xamã Sucatosso"
L["Scrapbone Trashtosser"] = "Taca-lixo Sucatosso"
L["Scraphound"] = "Cão-sucata"
L["Scrimshaw Enforcer"] = "Impositor Osso Talhado"
L["Scrimshaw Gutter"] = "Estripador Osso Talhado"
--[[Translation missing --]]
--[[ L["Seasonal Affix:"] = ""--]] 
--[[Translation missing --]]
--[[ L["Seat of the Archon"] = ""--]] 
--[[Translation missing --]]
--[[ L["Seat of the Triumvirate"] = ""--]] 
--[[Translation missing --]]
--[[ L["Seat of the Triumvirate Sublevel"] = ""--]] 
--[[Translation missing --]]
--[[ L["Select the dungeon level"] = ""--]] 
--[[Translation missing --]]
--[[ L["Sending: %.1f"] = ""--]] 
L["Seneschal M'bara"] = "Senescal M'bara"
L["Sentient Oil"] = "Óleo Senciente"
L["Separation Assistant"] = "Assistente de Separação"
L["Sergeant Bainbridge"] = "Sargento Belponte"
--[[Translation missing --]]
--[[ L["Settings"] = ""--]] 
--[[Translation missing --]]
--[[ L["Sewer Gate"] = ""--]] 
L["Sewer Vicejaw"] = "Boca-de-alicate de Esgoto"
--[[Translation missing --]]
--[[ L["Shackle Undead"] = ""--]] 
L["Shackled Soul"] = "Alma Agrilhoada"
L["Shadow of Zul"] = "Sombra de Zul"
L["Shadowblade Stalker"] = "Espreitador Umbralâmina"
L["Shadow-Borne Champion"] = "Campeão Umbréreo"
L["Shadow-Borne Warrior"] = "Guerreiro Umbréreo"
L["Shadow-Borne Witch Doctor"] = "Mandingueiro Umbréreo"
--[[Translation missing --]]
--[[ L["Shadowlands"] = ""--]] 
L["Shalebiter"] = "Xistófago"
L["Shambling Arbalest"] = "Arcobalista Claudicante"
L["Shard of Halkias"] = "Estilhaço de Hálkias"
--[[Translation missing --]]
--[[ L["Share"] = ""--]] 
--[[Translation missing --]]
--[[ L["Share the preset with your party members"] = ""--]] 
L["Shattered Visage"] = "Semblante Estilhaçado"
L["Shieldbearer of Zul"] = "Escudeiro de Zul"
--[[Translation missing --]]
--[[ L["Shift-Click to delete all presets for this dungeon"] = ""--]] 
L["Shiprat"] = "Rato de Navio"
--[[Translation missing --]]
--[[ L["Shock Bot"] = ""--]] 
--[[Translation missing --]]
--[[ L["Shortcut"] = ""--]] 
--[[Translation missing --]]
--[[ L["Shrine of the Storm"] = ""--]] 
--[[Translation missing --]]
--[[ L["Shrine of the Storm Sublevel"] = ""--]] 
L["Shrine Templar"] = "Templário do Santuário"
--[[Translation missing --]]
--[[ L["shrineGraveyardNote1"] = ""--]] 
L["Shrouded Fang"] = "Presa Oculta"
L["Shuffling Corpse"] = "Cadáver Manquejante"
--[[Translation missing --]]
--[[ L["Siege of Boralus"] = ""--]] 
--[[Translation missing --]]
--[[ L["Siege of Boralus (Upstairs)"] = ""--]] 
--[[Translation missing --]]
--[[ L["Siege of Boralus Sublevel"] = ""--]] 
--[[Translation missing --]]
--[[ L["siegeDuplicateNote"] = ""--]] 
--[[Translation missing --]]
--[[ L["siegeGraveyardNote1"] = ""--]] 
--[[Translation missing --]]
--[[ L["siegeGraveyardNote2"] = ""--]] 
--[[Translation missing --]]
--[[ L["siegeGraveyardNote3"] = ""--]] 
--[[Translation missing --]]
--[[ L["siegeGutterNote2"] = ""--]] 
--[[Translation missing --]]
--[[ L["siegeGuttersNote"] = ""--]] 
--[[Translation missing --]]
--[[ L["Silence"] = ""--]] 
L["Silt Crab"] = "Caranguejo Lodoso"
L["Sister Briar"] = "Irmã Rosália"
L["Sister Malady"] = "Irmã Moléstia"
L["Sister Solena"] = "Irmã Solena"
L["Skeletal Hunting Raptor"] = "Raptor Caçador Descarnado"
L["Skeletal Marauder"] = "Espoliador Descarnado"
L["Skeletal Monstrosity"] = "Monstruosidade Descarnada"
L["Skeletal Raptor"] = "Raptor Esquelético"
--[[Translation missing --]]
--[[ L["Skittish"] = ""--]] 
L["Skycap'n Kragg"] = "Capitão-do-céu Kragg"
L["Slime Elemental"] = "Elemental do Lodo"
L["Slime Tentacle"] = "Tentáculo de Visgo"
L["Slimy Morsel"] = "Naco Viscoso"
L["Slithering Ooze"] = "Gosma Rastejante"
--[[Translation missing --]]
--[[ L["Slow"] = ""--]] 
L["Snarling Dockhound"] = "Cão das Docas Rosnador"
L["Soggy Shiprat"] = "Rato de Navio Encharcado"
L["Son of Hakkar"] = "Filho de Hakkar"
L["Soul Essence"] = "Essência de Alma"
L["Soulbound Goliath"] = "Golias Vinculado"
L["Soulforged Bonereaver"] = "Ossolador Forjado em Almas"
L["Spare Parts"] = "Peças Sobressalentes"
L["Spark Channeler"] = "Canalizador de Centelhas Sombrio"
L["Spectral Beastmaster"] = "Senhora das Feras Espectral"
L["Spectral Berserker"] = "Berserker Espectral"
L["Spectral Brute"] = "Brutamontes Espectral"
L["Spectral Headhunter"] = "Caçador de Cabeças Espectral"
L["Spectral Hex Priest"] = "Sacerdote Bagateiro Espectral"
L["Spectral Witch Doctor"] = "Mandingueira Espectral"
L["Spider Tank"] = "Tanque Aranha"
L["Spinemaw Acidgullet"] = "Gorjácida Espinogórjeo"
L["Spinemaw Gorger"] = "Engolidor Espinogórjeo"
L["Spinemaw Larva"] = "Larva de Espinogórjeo"
L["Spinemaw Reaver"] = "Aniquilador Espinogórjeo"
L["Spinemaw Staghorn"] = "Galhagamo Espinogórjeo"
--[[Translation missing --]]
--[[ L["Spires of Ascension"] = ""--]] 
--[[Translation missing --]]
--[[ L["Spiteful"] = ""--]] 
L["Sporecaller Zancha"] = "Chama-esporos Zancha"
L["Spriggan Barkbinder"] = "Talacasca Vergônteo"
L["Spriggan Mendbender"] = "Vervigor Vergônteo"
--[[Translation missing --]]
--[[ L["Start or join the current |cFF00FF00Live Session|r"] = ""--]] 
L["Static-charged Dervish"] = "Dervixe Carregado de Estática"
L["Stealthling"] = "Furtivinho"
L["Stinging Parasite"] = "Parasita Aguilhoante"
L["Stitched Vanguard"] = "Vanguarda Suturada"
L["Stitchflesh's Creation"] = "Criação de Suturítico"
L["Stitching Assistant"] = "Assistente de Sutura"
L["Stoneborn Eviscerator"] = "Evisceradora Litonata"
L["Stoneborn Reaver"] = "Aniquiladora Litonata"
L["Stoneborn Slasher"] = "Rasgador Litonato"
L["Stonefiend Anklebiter"] = "Diabo de Pedra Morde-calcanhar"
L["Stonefury"] = "Furiapedra"
L["Stonewall Gargon"] = "Gargono Muro-de-pedra"
--[[Translation missing --]]
--[[ L["Storming"] = ""--]] 
--[[Translation missing --]]
--[[ L["Storm's End"] = ""--]] 
L["Strider Tonk"] = "Tonque Andante"
--[[Translation missing --]]
--[[ L["Stun"] = ""--]] 
L["Sunken Denizen"] = "Habitante Afundado"
L["Surgeon Stitchflesh"] = "Cirurgião Suturítico"
L["Tank Buster MK1"] = "Destruidor de Tanques MK1"
L["Taskmaster Askari"] = "Capataz Askari"
--[[Translation missing --]]
--[[ L["Taunt"] = ""--]] 
--[[Translation missing --]]
--[[ L["tdBuffGateNote"] = ""--]] 
--[[Translation missing --]]
--[[ L["tdGraveyardNote1"] = ""--]] 
--[[Translation missing --]]
--[[ L["tdGraveyardNote2"] = ""--]] 
--[[Translation missing --]]
--[[ L["tdGraveyardNote3"] = ""--]] 
--[[Translation missing --]]
--[[ L["tdHowlisNote"] = ""--]] 
--[[Translation missing --]]
--[[ L["TDPrisonKeyText"] = ""--]] 
--[[Translation missing --]]
--[[ L["tdWardenFightingNote"] = ""--]] 
L["Teeming"] = "Apinhada"
L["Temple Attendant"] = "Servo do Templo"
--[[Translation missing --]]
--[[ L["Temple of Sethraliss"] = ""--]] 
--[[Translation missing --]]
--[[ L["Temple of Sethraliss Sublevel"] = ""--]] 
--[[Translation missing --]]
--[[ L["templeEyeNote"] = ""--]] 
--[[Translation missing --]]
--[[ L["templeGraveyardNote1"] = ""--]] 
--[[Translation missing --]]
--[[ L["templeGraveyardNote2"] = ""--]] 
L["Territorial Bladebeak"] = "Bicossabre Territorial"
L["Test Subject"] = "Cobaia"
--[[Translation missing --]]
--[[ L["The Arcway"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Arcway Sublevel"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Balconies"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Banquet Hall"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Brig"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Cellar"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Drain"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Emerald Archives"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Festering Sanctum"] = ""--]] 
L["The Golden Serpent"] = "A Serpente Dourada"
--[[Translation missing --]]
--[[ L["The Grand Foyer"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Grand Hall"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Guest Chambers"] = ""--]] 
--[[Translation missing --]]
--[[ L["The High Gate"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Hold"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Jeweled Estate"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Menagerie"] = ""--]] 
--[[Translation missing --]]
--[[ L["The MOTHERLODE!!"] = ""--]] 
--[[Translation missing --]]
--[[ L["The MOTHERLODE!! Sublevel"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Naglfar"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Necrotic Wake"] = ""--]] 
L["The Platinum Pummeler"] = "Esbordoador de Platina"
--[[Translation missing --]]
--[[ L["The preset will continuously synchronize between all party members participating in the Live Session"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Raven's Crown"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Ravenscrypt"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Robodrome"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Rook's Host"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Rupture"] = ""--]] 
L["The Sand Queen"] = "A Rainha d'areia"
--[[Translation missing --]]
--[[ L["The selected affixes are not the ones of the current week"] = ""--]] 
--[[Translation missing --]]
--[[ L["The selected dungeon level is below 10"] = ""--]] 
--[[Translation missing --]]
--[[ L["The selected level will affect displayed npc health"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Servant's Quarters"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Under Junk"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Underrot"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Underrot Sublevel"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Warden's Court"] = ""--]] 
--[[Translation missing --]]
--[[ L["Theater of Pain"] = ""--]] 
--[[Translation missing --]]
--[[ L["theaterOfPain_miniBossNote"] = ""--]] 
--[[Translation missing --]]
--[[ L["TheaterOfPainFloor1"] = ""--]] 
--[[Translation missing --]]
--[[ L["TheaterOfPainFloor2"] = ""--]] 
--[[Translation missing --]]
--[[ L["TheaterOfPainFloor3"] = ""--]] 
--[[Translation missing --]]
--[[ L["TheaterOfPainFloor4"] = ""--]] 
--[[Translation missing --]]
--[[ L["TheaterOfPainFloor5"] = ""--]] 
--[[Translation missing --]]
--[[ L["TheNecroticWakeFloor1"] = ""--]] 
--[[Translation missing --]]
--[[ L["TheNecroticWakeFloor2"] = ""--]] 
--[[Translation missing --]]
--[[ L["TheNecroticWakeFloor3"] = ""--]] 
L["Thistle Acolyte"] = "Acólita do Cardo"
L["Thornguard"] = "Cardoguarda"
L["Tidesage Enforcer"] = "Sábio das Marés Impositor"
L["Tidesage Initiate"] = "Sábio das Marés Novato"
L["Tidesage Spiritualist"] = "Espiritualista Sábia das Marés"
L["Tirnenn Villager"] = "Habitante da Vila Tirnenn"
L["T'lonja"] = "T'lonja"
--[[Translation missing --]]
--[[ L["To share a different preset while the live session is active simply navigate to the preferred preset and click the new 'Set to Live' Button next to the preset-dropdown"] = ""--]] 
--[[Translation missing --]]
--[[ L["tocNotes"] = ""--]] 
--[[Translation missing --]]
--[[ L["Toggle Window"] = ""--]] 
L["Toiling Groundskeeper"] = "Zelador Mourejante"
--[[Translation missing --]]
--[[ L["Tol Dagor"] = ""--]] 
--[[Translation missing --]]
--[[ L["Tol Dagor Sublevel1"] = ""--]] 
L["Tormented Soul"] = "Alma Atormentada"
--[[Translation missing --]]
--[[ L["Total"] = ""--]] 
L["Toxic Lurker"] = "Tocaieiro Tóxico"
L["Toxic Monstrosity"] = "Monstruosidade Tóxica"
L["Toxic Saurid"] = "Saurídeo Tóxico"
L["Tred'ova"] = "Tred'ova"
L["Trixie Tazer"] = "Chica Létrica"
L["Trothak"] = "Trothak"
--[[Translation missing --]]
--[[ L["Twilight Grove"] = ""--]] 
--[[Translation missing --]]
--[[ L["Tyrannical"] = ""--]] 
L["Unbound Abomination"] = "Abominação Liberta"
--[[Translation missing --]]
--[[ L["Undead"] = ""--]] 
L["Underrot Tick"] = "Carrapato da Terra Podre"
--[[Translation missing --]]
--[[ L["underrotMatronNote"] = ""--]] 
--[[Translation missing --]]
--[[ L["underrotSkipNote"] = ""--]] 
--[[Translation missing --]]
--[[ L["underrotVoidNote"] = ""--]] 
--[[Translation missing --]]
--[[ L["Undo"] = ""--]] 
L["Undying Stonefiend"] = "Diabo de Pedra Imorredouro"
L["Unstable Canister"] = "Lata Instável"
L["Unstable Larva"] = "Larva Instável"
L["Unyielding Contender"] = "Competidor Obstinado"
--[[Translation missing --]]
--[[ L["Update"] = ""--]] 
--[[Translation missing --]]
--[[ L["Upper Broken Stair"] = ""--]] 
--[[Translation missing --]]
--[[ L["Upper Library"] = ""--]] 
--[[Translation missing --]]
--[[ L["Upper Livery Stables"] = ""--]] 
--[[Translation missing --]]
--[[ L["Upstairs"] = ""--]] 
L["Urg'roth, Breaker of Heroes"] = "Urg'roth, Rachador de Heróis"
--[[Translation missing --]]
--[[ L["Use /mdt reset to restore the default position and scale of MDT."] = ""--]] 
--[[Translation missing --]]
--[[ L["Use as a starting point:"] = ""--]] 
--[[Translation missing --]]
--[[ L["Vault of the Betrayer"] = ""--]] 
--[[Translation missing --]]
--[[ L["Vault of the Wardens"] = ""--]] 
--[[Translation missing --]]
--[[ L["Vault of the Wardens Sublevel"] = ""--]] 
L["Venomfang"] = "Peçonhenta"
L["Venomous Ophidian"] = "Ofídio Venenoso"
L["Venomous Sniper"] = "Franco-atirador Venenoso"
L["Venomous Sniper Captain"] = "Capitão Atirador Peçonha"
L["Ventunax"] = "Ventunax"
L["Venture Co. Alchemist"] = "Alquimista da Empreendimentos S.A."
L["Venture Co. Earthshaper"] = "Moldaterra da Empreendimentos S.A."
L["Venture Co. Longshoreman"] = "Estivador da Empreendimentos S.A."
L["Venture Co. Mastermind"] = "Mandante da Empreendimentos S.A."
L["Venture Co. Skyscorcher"] = "Queimacéu da Empreendimentos S.A."
L["Venture Co. War Machine"] = "Máquina de Guerra da Empreendimentos S.A."
L["Vermin Trapper"] = "Coureador Rateiro"
L["Vestige of Doubt"] = "Vestígio de Dúvida"
L["Vicious Gargon"] = "Gargono Cruel"
L["Viq'Goth"] = "Viq'Goth"
L["Virulax Blightweaver"] = "Tecepragas Virulax"
L["Void-Touched Emissary"] = "Emissária Tocada pelo Caos"
L["Voidweaver Mal'thir"] = "Tececaos Mal'thir"
L["Volatile Memory"] = "Lembrança Volátil"
--[[Translation missing --]]
--[[ L["Volcanic"] = ""--]] 
L["Vol'kaal"] = "Vol'kaal"
L["Vol'zith the Whisperer"] = "Vol'zith, a Sussurrante"
L["Wanton Sapper"] = "Sapadora Devassa"
--[[Translation missing --]]
--[[ L["Waste Pipes"] = ""--]] 
L["Waste Processing Unit"] = "Unidade de Processamento de Dejetos"
--[[Translation missing --]]
--[[ L["Waycrest Manor"] = ""--]] 
L["Waycrest Reveler"] = "Folião Capelo"
--[[Translation missing --]]
--[[ L["wcmWorldquestNote"] = ""--]] 
L["Weald Shimmermoth"] = "Lumídia do Bosque"
L["Weaponized Crawler"] = "Rastejante Armificado"
L["Weapons Tester"] = "Testador de Armas"
--[[Translation missing --]]
--[[ L["Welding Bot"] = ""--]] 
L["Wicked Oppressor"] = "Opressora Perversa"
L["Windspeaker Heldis"] = "Voz dos Ventos Heldis"
L["Workshop Defender"] = "Defensor da Oficina"
L["Xav the Unfallen"] = "Xav, o Não-caído"
L["Xira the Underhanded"] = "Zira, a Dissimulada"
L["Yazma"] = "Yazma"
--[[Translation missing --]]
--[[ L["You are using MDT. You rock!"] = ""--]] 
--[[Translation missing --]]
--[[ L["You can always return to the current Live Session preset by clicking the 'Return to Live' button next to the preset-dropdown"] = ""--]] 
--[[Translation missing --]]
--[[ L["You can choose from different color palettes in the automatic pull coloring settings menu."] = ""--]] 
--[[Translation missing --]]
--[[ L["You can cycle through different floors by holding CTRL and using the mousewheel."] = ""--]] 
--[[Translation missing --]]
--[[ L["You can cycle through dungeons by holding ALT and using the mousewheel."] = ""--]] 
--[[Translation missing --]]
--[[ L["You can find MDT exports from other users on the wago.io website"] = ""--]] 
--[[Translation missing --]]
--[[ L["You can share MDT exports on the wago.io website"] = ""--]] 
L["Zanazal the Wise"] = "Zanazal, o Sábio"
L["Zanchuli Witch-Doctor"] = "Mandingueira Zanchuli"
L["Zolramus Bonecarver"] = "Entalha-ossos Zoralmus"
L["Zolramus Bonemender"] = "Junta-ossos Zoralmus"
L["Zolramus Gatekeeper"] = "Guarda-pórtico Zolramus"
L["Zolramus Necromancer"] = "Necromante Zolramus"
L["Zolramus Siphoner"] = "Canalizadora de Zolramus"
L["Zolramus Sorcerer"] = "Feiticeiro Zolramus"
--[[Translation missing --]]
--[[ L["Zul'Gurub"] = ""--]] 

