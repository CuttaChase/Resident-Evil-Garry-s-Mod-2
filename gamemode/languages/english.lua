--[[
English is the standard language that you should base your ID's off of.
If something isn't found in your language file then it will fall back to English.
Valid languages (from gmod's menu): bg cs da de el en en-PT es-ES et fi fr ga-IE he hr hu it ja ko lt nl no pl pt-BR pt-PT ru sk sv-SE th tr uk vi zh-CN zh-TW
You MUST use one of the above when using translate.AddLanguage
]]

--[[
RULES FOR TRANSLATORS!!
* Only translate formally. Do not translate with slang, improper grammar, spelling, etc.
* Comment out things that you have not yet translated in your language file.
  It will then fall back to this file instead of potentially using out of date wording in yours.
]]

translate.AddLanguage("en", "English")

--Scoreboard
LANGUAGE.players                             = "Players"
LANGUAGE.name                                = "Name"
LANGUAGE.money                               = "Money"
LANGUAGE.kills_score                         = "Kills"
LANGUAGE.ping                                = "Ping"
LANGUAGE.survivors                           = "Survivors"
LANGUAGE.unfortunate                         = "The Unfortunate"

--HUD(Screen stuff)
LANGUAGE.kills                               = "Kills"
LANGUAGE.dead_zombies                        = "Dead Zombies"
LANGUAGE.condition                           = "Condition"
LANGUAGE.game                                = "Game"
LANGUAGE.difficulty                          = "Difficulty"
LANGUAGE.starting_in                         = "Starting in"
LANGUAGE.time_alive                          = "Time Alive"
LANGUAGE.time_left                           = "Time Left"
LANGUAGE.your_kills                          = "Your Kills"
LANGUAGE.your_time                           = "Your Time"
LANGUAGE.gametime                            = "GameTime"
LANGUAGE.fine                                = "Fine"
LANGUAGE.caution                             = "Caution"
LANGUAGE.danger                              = "Danger"
LANGUAGE.dead                                = "Dead"

--Vote Menu
LANGUAGE.voting_menu                         = "Voting"
LANGUAGE.select_map                          = "Select A Map"
LANGUAGE.difficulty_vote                     = "Difficulty"
LANGUAGE.gamemode                            = "Gamemode"
LANGUAGE.easy                                = "Easy"
LANGUAGE.normal                              = "Normal"
LANGUAGE.difficult                           = "Difficult"
LANGUAGE.expert                              = "Expert"
LANGUAGE.suicidal                            = "Suicidal"
LANGUAGE.death                               = "Death"
LANGUAGE.racooncity                          = "RacoonCity"
LANGUAGE.submit_vote                         = "Submit Your Vote"
LANGUAGE.change_vote                         = "Change Vote"
LANGUAGE.you_selected                        = "You selected"
LANGUAGE.for_next_dificulty                  = "for the next difficulty."
LANGUAGE.for_next_map                        = "for the next map."
LANGUAGE.for_next_gamemode                   = "for the next gamemode."
LANGUAGE.you_want_crows                      = "You want spectators to become crows."
LANGUAGE.you_wont_crows                      = "You don't want spectators to become crows."
LANGUAGE.you_want_classic                    = "You want to play Classic mode."
LANGUAGE.you_wont_classic                    = "You don't want to play Classic mode."

--Admin Menu
LANGUAGE.admin_menu                          = "Admin"
LANGUAGE.pause_times                         = "Pause Timer"
LANGUAGE.unpause_times                       = "UnPause Timer"
LANGUAGE.set_money                           = "Set Money"
LANGUAGE.select_player                       = "Select Player"
LANGUAGE.create_weapon                       = "Create Weapon"
LANGUAGE.weapons                             = "Weapons"
LANGUAGE.weapon_spawned                      = "Weapon spawned."
LANGUAGE.create_item                         = "Create Item"
LANGUAGE.items                               = "Items"
LANGUAGE.item_count                          = "Item Count"
LANGUAGE.set_difficulty                      = "Set Difficulty"
LANGUAGE.difficulty_admin                    = "Difficulty"
LANGUAGE.healcure                            = "Heal & Cure Player"
LANGUAGE.players_admin                       = "Players"

--Chest Menu
LANGUAGE.chest_menu                          = "Chest"
LANGUAGE.storage                             = "Storage"
LANGUAGE.storage_msg                         = "Store your guns here"
LANGUAGE.inventory                           = "Inventory"
LANGUAGE.inventory_msg                       = "Manage Your Guns here"
LANGUAGE.deposit                             = "Deposit"
LANGUAGE.withdraw                            = "Withdraw"
LANGUAGE.damage                              = "Damage"
LANGUAGE.accuracy                            = "Accuracy"
LANGUAGE.clip_size                           = "Clip Size"
LANGUAGE.firing_speed                        = "Firing Speed"
LANGUAGE.reload_speed                        = "Reload Speed"
LANGUAGE.many_weapons                        = "Too many weapons"

--Upgrades Menu
LANGUAGE.upgrades_menu                       = "Upgrades"
LANGUAGE.upgrade_weapons                     = "Upgrade Weapons"
LANGUAGE.upgrade                             = "Upgrade"
LANGUAGE.upgrade_weapons_msg                 = "I wonder what you would buy here?"

--Skills Menu
LANGUAGE.skills_menu                         = "Skills"
LANGUAGE.perks                               = "Perks"
LANGUAGE.perks_msg                           = "I wonder what you would buy here?"

--Store Menu
LANGUAGE.store_menu                          = "Store"
LANGUAGE.buy_weapons                         = "Buy Weapons"
LANGUAGE.buy_weapons_msg                     = "I wonder what you would buy here?"
LANGUAGE.buy_items                           = "Buy Items"
LANGUAGE.buy_items_msg                       = "I wonder what you would buy here?"
LANGUAGE.buy_for                             = "Buy for"
LANGUAGE.max_power                           = "Maximum Power Level"
LANGUAGE.max_accuracy                        = "Maximum Accuracy Level"
LANGUAGE.max_clipsize                        = "Maximum Clip Size Level"
LANGUAGE.max_firingspeed                     = "Maximum Firing Speed Level"
LANGUAGE.max_reloadspeed                     = "Maximum Reload Speed Level"

--Inventory
LANGUAGE.use                                 = "Use"
LANGUAGE.give                                = "Give"
LANGUAGE.drop                                = "Drop"
LANGUAGE.use_on                              = "Use On"

--Items
LANGUAGE.spray                               = "Spray"
LANGUAGE.spray_desc                          = "Heals all wounds"
LANGUAGE.green_herb                          = "Green Herb"
LANGUAGE.green_herb_desk                     = "Heals Some wounds"
LANGUAGE.red_herb                            = "Red Herb"
LANGUAGE.red_herb_desk                       = "Chance To Cure Infection"
LANGUAGE.infection_lowered                   = "Infection Lowered"
LANGUAGE.tvirus_cure                         = "T-Virus Cure"
LANGUAGE.tvirus_cure_desk                    = "Cures Infection"
LANGUAGE.infection_cured                     = "Infection Cured"
LANGUAGE.pistol_ammo                         = "Pistol Ammo"
LANGUAGE.pistol_ammo_desk                    = "40 rounds"
LANGUAGE.shotgun_ammo                        = "Shotgun Ammo"
LANGUAGE.shotgun_ammo_desk                   = "36 rounds"
LANGUAGE.auto_ammo                           = "Automatic Ammo"
LANGUAGE.auto_ammo_desk                      = "45 rounds"
LANGUAGE.rifle_ammo                          = "Rifle Ammo"
LANGUAGE.rifle_ammo_desk                     = "60 rounds"
LANGUAGE.magnum_ammo                         = "Magnum Rounds"
LANGUAGE.magnum_ammo_desk                    = "35 rounds"
LANGUAGE.sniper_ammo                         = "Sniper Rounds"
LANGUAGE.sniper_ammo_desk                    = "20 rounds"
LANGUAGE.rocket_round                        = "Rocket Round"
LANGUAGE.rocket_round_desk                   = "4 rockets"
LANGUAGE.explosive_rounds                    = "Explosive Rounds"
LANGUAGE.explosive_rounds_desk               = "6 rounds"
LANGUAGE.flame_rounds                        = "Flame Rounds"
LANGUAGE.flame_rounds_desk                   = "6 rounds"
LANGUAGE.freeze_rounds                       = "Freeze Rounds"
LANGUAGE.freeze_rounds_desk                  = "6 rounds"
LANGUAGE.proximity_mine                      = "Proximity Mine"
LANGUAGE.proximity_mine_desk                 = "Plants at your feet."
LANGUAGE.c4                                  = "C4 Plastic Explosive"
LANGUAGE.c4_desk                             = "Plant and Detonate"
LANGUAGE.expbarrel                           = "Explosive Barrel"
LANGUAGE.expbarrel_desk                      = "Read the name"

--Weapons
LANGUAGE.pistol_ammo_use                     = "Uses Pistol Ammo"
LANGUAGE.rifle_ammo_use                      = "Uses Rifle Ammo"
LANGUAGE.automatic_ammo_use                  = "Uses Automatic Ammo"
LANGUAGE.shotgun_ammo_use                    = "Uses Shotgun Ammo"
LANGUAGE.magnum_ammo_use                     = "Uses Magnum rounds"
LANGUAGE.sniper_ammo_use                     = "Uses Sniper Ammo"
LANGUAGE.pistol_9mm                          = "9mm Handgun"
LANGUAGE.m4a1                                = "M4a1"
LANGUAGE.p90                                 = "P90"
LANGUAGE.pump_shotgun                        = "Pump Shotgun"
LANGUAGE.glock18                             = "Glock-18c"
LANGUAGE.aug                                 = "Aug"
LANGUAGE.mp5                                 = "Mp5"
LANGUAGE.ragerev                             = "Raging Revolver"
LANGUAGE.ump                                 = "Ump 45"
LANGUAGE.deagle                              = "Night Hawk .50C"
LANGUAGE.p228                                = "Sig P-220"
LANGUAGE.ak47                                = "Ak-47"
LANGUAGE.striker7                            = "Striker-7"
LANGUAGE.spas12                              = "Spas-12"
LANGUAGE.m29                                 = "M29 Satan Deux"
LANGUAGE.gravgun                             = "Gravity Gun"
LANGUAGE.gravgun_desk                        = "Catch!"
LANGUAGE.awp                                 = "AWP"
LANGUAGE.scout                               = "Scout Sniper"
 
--Power Weapons
LANGUAGE.m79                                 = "M79 Grenade Launcher"
LANGUAGE.m79_desk                            = "Right Click to Change Ammo Types"
LANGUAGE.quadrpg                             = "Quad Rocket Launcher"
LANGUAGE.quadrpg_desk                        = "4 Rockets."
LANGUAGE.minigun                             = "Minigun"
LANGUAGE.minigun_desk                        = "200 rounds of death. Rip it up."
LANGUAGE.bandolier                           = "Minigun Bandolier"
LANGUAGE.bandolier_desk                      = "Gives 200 more Rounds."

--COD:BO2 Weapons
LANGUAGE.an94                                = "AN94"
LANGUAGE.ballista                            = "Ballista"
LANGUAGE.dsr50                               = "DSR50"
LANGUAGE.executioner                         = "Executioner"
LANGUAGE.kap40                               = "Kap40"
LANGUAGE.peace                               = "PeaceKeeper"
LANGUAGE.pdw                                 = "PDW"

--Gamemodes
LANGUAGE.cant_suicide                        = "You can't suicide!"
LANGUAGE.you_earned                          = "You earned $%s"
LANGUAGE.boss_appeared                       = "Boss has appeared...KILL HIM!"
LANGUAGE.boss_killed                         = "Players killed nemesis, $%s to everyone"
LANGUAGE.boss_not_killed                     = "Players did not kill the Boss, no cash earned"
LANGUAGE.won                                 = "%n won %s for getting the most kills. Well done!"
LANGUAGE.vip_survived                        = "The Vip has survived! All players won $%s . Fine Work!"
LANGUAGE.vip_died                            = "The Vip has died, nobody is rewarded a special bonus."
LANGUAGE.protect_vip                         = "Protect This Player"
LANGUAGE.you_vip                             = "You are the Vip"
LANGUAGE.umbrella_win                        = "Umbrella Wins"
LANGUAGE.stars_win                           = "S.T.A.R.S Wins"
LANGUAGE.survived                            = "Surviving players won $%s for staying alive. Well done!"
LANGUAGE.teamvip_won                         = "The %n Team Won! They are awarded $%s each. Fine Work!"
LANGUAGE.not_enough_players                  = "Not Enough Players, It is now Survivor"
LANGUAGE.survivormessage1                    = "Press Q To Open Inventory/Open Merchant"
LANGUAGE.survivormessage2                    = "Merchant Is Only Accessible In Merchant Room"
LANGUAGE.survivormessage3                    = "Purchased Items Will Go To Your Storage"
LANGUAGE.survivormessage4                    = "If Your Infection Gets to 100, You Die"
LANGUAGE.survivormessage5                    = "To Remove These Messages, Press F1 and Toggle Content Messages"
LANGUAGE.crowmessage1                        = "Crows Can Attack Survivors With Right Click"
LANGUAGE.crowmessage2                        = "You can earn money from attacking survivors"
LANGUAGE.crowmessage3                        = "Can choose to help survivors or help zombies"
LANGUAGE.crowmessage4                        = "You can attack zombies but give no money"
LANGUAGE.crowmessage5                        = "To Remove These Messages, Press F1 and Toggle Content Messages"






