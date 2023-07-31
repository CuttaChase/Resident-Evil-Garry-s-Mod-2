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
LANGUAGE.scoreboard_format_team_and_players  = "%s  (%s Players)"
LANGUAGE.name                                = "Name"
LANGUAGE.money                               = "Money"
LANGUAGE.kills_score                         = "Kills"
LANGUAGE.ping                                = "Ping"
LANGUAGE.team_survivors                      = "Survivors"
LANGUAGE.team_spectator                      = "Spectator"
LANGUAGE.team_crows                          = "Crows"
LANGUAGE.gamemode_by_x                       = "Gamemode By : %s"

--HUD(Screen stuff)
LANGUAGE.kills_x_format                      = "Kills: %s"
LANGUAGE.dead_zombies_format                 = "Dead Zombies : %s/%s"
LANGUAGE.dead_zombies_format2                = "Dead Zombies : %s"
LANGUAGE.dead_zombies_format3                = "Dead Zombies : "
LANGUAGE.dead_zombies_format4                = "%s/%s"
LANGUAGE.condition_format_status             = "Condition: %s"
LANGUAGE.status_fine                         = "Fine"
LANGUAGE.status_caution                      = "Caution"
LANGUAGE.status_danger                       = "Danger"
LANGUAGE.status_dead                         = "Dead"
LANGUAGE.game_format_name                    = "Game : %s"
LANGUAGE.gametype_mercenaries                = "Mercenaries"
LANGUAGE.gametype_vip                        = "VIP"
LANGUAGE.gametype_teamvip                    = "Team VIP"
LANGUAGE.gametype_boss                       = "Boss"
LANGUAGE.gametype_survivor                   = "Survivor"
LANGUAGE.gametype_doom                       = "Doom"
LANGUAGE.gametype_merchant                   = "Merchant"
LANGUAGE.gametype_escape                     = "Escape"
LANGUAGE.gametype_pvp                        = "PVP"
LANGUAGE.gametype_lastmanstanding            = "Last Man Standing"
LANGUAGE.difficulty_format_name              = "Difficulty: %s"
LANGUAGE.starting_in_x_format                = "Starting in : %s"
LANGUAGE.time_alive_x_format                 = "Time Alive : %s"
LANGUAGE.time_left_x_format                  = "Time Left : %s"
LANGUAGE.your_kills_x_format                 = "Your Kills: %s"
LANGUAGE.your_time_x_format                  = "Your Time : %s"
LANGUAGE.gametime_x_format                   = "Game Time : %s"
LANGUAGE.money_x_format                      = "Money $%s"
LANGUAGE.money_x_format2                     = "$%s"
LANGUAGE.mags_x_format                       = "Magazine:  %s"
LANGUAGE.ammo_x_format                       = "Ammo:  %s"

--Vote Menu
LANGUAGE.voting_menu                         = "Voting"
LANGUAGE.select_map                          = "Select A Map"
LANGUAGE.difficulty_vote                     = "Difficulty"
LANGUAGE.gamemode                            = "Gamemode"
LANGUAGE.difficulty_name_easy                = "Easy"
LANGUAGE.difficulty_name_normal              = "Normal"
LANGUAGE.difficulty_name_difficult           = "Difficult"
LANGUAGE.difficulty_name_expert              = "Expert"
LANGUAGE.difficulty_name_suicidal            = "Suicidal"
LANGUAGE.difficulty_name_death               = "Death"
LANGUAGE.difficulty_name_racooncity          = "Raccoon City"
LANGUAGE.submit_vote                         = "Submit Your Vote"
LANGUAGE.change_vote                         = "Change Vote"
LANGUAGE.you_selected_difficulty             = "You selected %s"
LANGUAGE.you_selected_map                    = "You selected %s"
LANGUAGE.you_selected_gamemode               = "You selected %s"
LANGUAGE.player_voted_difficulty_on_map_and_mode = "%s Voted %s on %s and gamemode %s"
LANGUAGE.changing_map_will_gamemode_on_difficulty = "Changing to %s in 5 seconds. The gamemode will be %s On %s"
LANGUAGE.default_map_result                  = "Default Map Choice Because No One Voted"
LANGUAGE.no_maps_for_gametype                = "No maps available for %s"
LANGUAGE.voting_menu_close                   = "Close Menu"

--Inventory
LANGUAGE.item_slot_x                         = "SLOT %s"
LANGUAGE.item_slot_empty                     = "EMPTY"
LANGUAGE.item_slot_locked                    = "LOCKED"
LANGUAGE.inventory_open_shop                 = "Open Merchant"
LANGUAGE.use                                 = "Use"
LANGUAGE.give                                = "Give"
LANGUAGE.drop                                = "Drop"

--Merchant
LANGUAGE.merchant_category_upgrades          = "Upgrades"
LANGUAGE.merchant_category_storage           = "Storage"
LANGUAGE.merchant_category_perks             = "Perks"
LANGUAGE.merchant_category_shop              = "Shop"
LANGUAGE.merchant_category_playermodels      = "Player Models"
LANGUAGE.merchant_menu_close                 = "Close Menu"

--Shop Menu
LANGUAGE.shop_title                          = "Shop"
LANGUAGE.shop_current_money                  = "Money: $%s"
LANGUAGE.shop_x_storage_slots                = "%s / %s Storage Slots"
LANGUAGE.shop_item_category_weapons          = "Weapons"
LANGUAGE.shop_item_category_ammunition       = "Ammunition"
LANGUAGE.shop_item_category_supplies         = "Supplies"
LANGUAGE.shop_item_category_admin            = "Admin"
LANGUAGE.item_price_x                        = "Price: %s"
LANGUAGE.shop_buy_button                     = "Buy"

--Upgrades Menu
LANGUAGE.weapon_upgrades_title               = "Weapon Upgrades"
LANGUAGE.upgrade_format                      = "%s: %s ( LEVEL %s )"
LANGUAGE.upgrade_format_max                  = "%s: %s ( MAX LEVEL )"
LANGUAGE.upgrade_button                      = "Upgrade %s ( $%s )"

--Storage Menu
LANGUAGE.storage_title                       = "Storage"
LANGUAGE.storage_inventory_title             = "Inventory"
LANGUAGE.storage_purchase_slot               = "Purchase Slot ( $%s )"
LANGUAGE.storage_store_button                = "Store"
LANGUAGE.storage_sell_button                 = "Sell"
LANGUAGE.storage_equip_button                = "Equip"

--Perks Menu
LANGUAGE.perkmenu_title                      = "Perk Menu"
LANGUAGE.perkmenu_no_perk                    = "NO PERK SELECTED"
LANGUAGE.perkmenu_perk_slot_x                = "SLOT %s"
LANGUAGE.perkmenu_perk_category_attack       = "Attack"
LANGUAGE.perkmenu_perk_category_defense      = "Defense"
LANGUAGE.perkmenu_perk_category_donorperks   = "Donor Perks"
LANGUAGE.perkmenu_equip_slot1                = "Equip Slot 1"
LANGUAGE.perkmenu_equip_slot2                = "Equip Slot 2"
LANGUAGE.perkmenu_equip_slot3                = "Equip Slot 3"
LANGUAGE.perkmenu_perk_equipped              = "EQUIPPED"
LANGUAGE.perkmenu_unequip                    = "Unequip"

--Player Model Menu
LANGUAGE.playermodels_title                  = "Player Models"
LANGUAGE.playermodels_model_category_models  = "Models"
LANGUAGE.playermodels_preview_button         = "Preview"
LANGUAGE.playermodels_model_owned            = "Owned"
LANGUAGE.playermodels_equip_button           = "Equip"
LANGUAGE.playermodels_model_equipped         = "EQUIPPED"
LANGUAGE.playermodels_unequip_button         = "Unequip"
LANGUAGE.playermodels_model_locked           = "LOCKED"

--Player Model Names
LANGUAGE.model_name_hunk                     = "Hunk"
LANGUAGE.model_name_leon_s_kennedy           = "Leon S Kennedy"
LANGUAGE.model_name_claire_redfield          = "Claire Redfield"
LANGUAGE.model_name_ada_wong                 = "ADA Wong"

--Upgrades(Upgrades Menu)
LANGUAGE.upgrade_name_chambering             = "CHAMBERING"
LANGUAGE.upgrade_stat_chambering             = "%s SHOTS PER SECOND"
LANGUAGE.upgrade_name_precision              = "PRECISION"
LANGUAGE.upgrade_stat_precision              = "%sm SPREAD"
LANGUAGE.upgrade_name_capacity               = "CAPACITY"
LANGUAGE.upgrade_stat_capacity               = "%s ROUNDS PER MAG"
LANGUAGE.upgrade_name_power                  = "POWER"
LANGUAGE.upgrade_stat_power                  = "%s DAMAGE"


--Options F1 menu
LANGUAGE.options_title                       = "Options"
LANGUAGE.options_enable_content_msgs         = "Enable Content Messages"
LANGUAGE.options_enable_music                = "Enable Music"
LANGUAGE.options_laser_color                 = "Laser Color"
LANGUAGE.options_close_menu                  = "Close Menu"

--Gamemodes
LANGUAGE.you_earned                          = "You earned $%s"
LANGUAGE.boss_appeared                       = "Boss has appeared...KILL HIM!"
LANGUAGE.boss_killed                         = "Players killed nemesis, $%s to everyone"
LANGUAGE.boss_not_killed                     = "Players did not kill the Boss, no cash earned"
LANGUAGE.won                                 = "%n won %s for getting the most kills. Well done!"
LANGUAGE.vip_survived                        = "The Vip has survived! All players won $%s. Fine Work!"
LANGUAGE.vip_died                            = "The Vip has died, nobody is rewarded a special bonus."
LANGUAGE.protect_vip                         = "Protect This Player"
LANGUAGE.you_vip                             = "You are the Vip"
LANGUAGE.umbrella_win                        = "Umbrella Wins"
LANGUAGE.stars_win                           = "S.T.A.R.S Wins"
LANGUAGE.survived                            = "Surviving players won $%s for staying alive. Well done!"
LANGUAGE.teamvip_won                         = "The %s Team Won! They are awarded $%s each. Fine Work!"
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
LANGUAGE.infection_lowered                   = "Infection Lowered"
LANGUAGE.you_are_not_infected                = "You are not infected!"
LANGUAGE.infection_cured                     = "Infection Cured"
LANGUAGE.you_found_x_dollars                 = "You found $%s"
LANGUAGE.x_gave_you_a_x_item                 = "%s gave you a %s"
LANGUAGE.you_gave_x_a_x_item                 = "You gave %s a %s"
LANGUAGE.last_person_alive_won_x_reward      = "Last Person Alive won %s. Well done!"
LANGUAGE.the_winner_is_x_and_won_x_reward    = "The Winner Is %s And Won %s. Well done!"
LANGUAGE.kill_enough_zombies_to_win          = "Kill Enough Zombies To Win!"
LANGUAGE.escaped_won_x_reward                = "You Have Escaped! Surviving players won $%s for staying alive. Well done!"
LANGUAGE.survivors_survived_x_reward         = "%s out of %s survivors survived, every survivor gets a bonus of $%s for team-work!"
LANGUAGE.unstuck_only_once                   = "Can Only Do Once"
LANGUAGE.resisted_infection                  = "Resisted Infection"


--Shop/Inventory/Storage Weapons
LANGUAGE.item_name_9mm_USP                      = "9mm USP"
LANGUAGE.item_desc_9mm_USP                      = "Uses Pistol Ammo"
LANGUAGE.item_name_UMP                      = "UMP"
LANGUAGE.item_desc_UMP                      = "Uses SMG Ammo"
LANGUAGE.item_name_Striker7                      = "Striker 7"
LANGUAGE.item_desc_Striker7                      = "Uses Shotgun Ammo"
LANGUAGE.item_name_Spas12                       = "Spas12"
LANGUAGE.item_desc_Spas12                      = "Uses Shotgun Ammo"
LANGUAGE.item_name_ragerev                       = "Raging Revolver"
LANGUAGE.item_desc_ragerev                       = "Uses Magnum Ammo"
LANGUAGE.item_name_quadrpg                        = "Quad Rocket Launcher"
LANGUAGE.item_desc_quadrpg                        = "Has Limited Ammo"
LANGUAGE.item_name_pumpshot                       = "Pump Shotgun"
LANGUAGE.item_desc_pumpshot                       = "Uses Shotgun Ammo"
LANGUAGE.item_name_P228                       = "P228"
LANGUAGE.item_desc_P228                       = "Uses Pistol Ammo"
LANGUAGE.item_name_P90                       = "P90"
LANGUAGE.item_desc_P90                       = "Uses SMG Ammo"
LANGUAGE.item_name_MP5                       = "MP5"
LANGUAGE.item_desc_MP5                       = "Uses SMG Ammo"
LANGUAGE.item_name_Minigun                      = "Minigun"
LANGUAGE.item_desc_Minigun                      = "Has Limited Ammo"
LANGUAGE.item_name_M4A1                   = "M4A1"
LANGUAGE.item_desc_M4A1                   = "Uses Rifle Ammo"
LANGUAGE.item_name_Glock18                       = "Glock 18"
LANGUAGE.item_desc_Glock18                       = "Uses Pistol Ammo"
LANGUAGE.item_name_glauncher                     = "Grenade Launcher"
LANGUAGE.item_desc_glauncher                     = "Uses Grenade Ammo"
LANGUAGE.item_name_Deagle                  = "Deagle"
LANGUAGE.item_desc_Deagle                  = "Uses Magnum Ammo"
LANGUAGE.item_name_AK47                       = "AK 47"
LANGUAGE.item_desc_AK47                       = "Uses Rifle Ammo"

--Shop/Inventory/Storage Ammo
LANGUAGE.item_name_rifleammo                 = "Rifle Ammo"
LANGUAGE.item_desc_rifleammo                 = "40 rounds"
LANGUAGE.item_name_buckshotammo              = "Shotgun Ammo"
LANGUAGE.item_desc_buckshotammo              = "10 rounds"
LANGUAGE.item_name_smgammo                   = "SMG Ammo"
LANGUAGE.item_desc_smgammo                   = "50 rounds"
LANGUAGE.item_name_magnumammo                = "Magnum Rounds"
LANGUAGE.item_desc_magnumammo                = "12 rounds"
LANGUAGE.item_name_pistolammo                = "Pistol Ammo"
LANGUAGE.item_desc_pistolammo                = "30 rounds"

--Shop/Inventory/Storage Supplies
LANGUAGE.item_name_barricade                 = "Barricade"
LANGUAGE.item_desc_barricade                 = "Keep Zombies Out"
LANGUAGE.item_name_tcure                     = "Virus Cure"
LANGUAGE.item_desc_tcure                     = "Cures any infection"
LANGUAGE.item_name_spray                     = "Spray"
LANGUAGE.item_desc_spray                     = "Heals all wounds"
LANGUAGE.item_name_bherb                     = "Blue Herb"
LANGUAGE.item_desc_bherb                     = "Its A Weird Thing"
LANGUAGE.item_name_C4                        = "C4 Plastic Explosive"
LANGUAGE.item_desc_C4                        = "Remote Detonation"
LANGUAGE.item_name_gherb                     = "Green Herb"
LANGUAGE.item_desc_gherb                     = "Heals Some wounds"
LANGUAGE.item_name_rherb                     = "Red Herb"
LANGUAGE.item_desc_rherb                     = "Can Help With Infection"
LANGUAGE.item_name_landmine                  = "Landmine"
LANGUAGE.item_desc_landmine                  = "Proximity Detonation"
LANGUAGE.item_name_decoy                     = "Decoy Bomb"
LANGUAGE.item_desc_decoy                     = "Explodes after 6 seconds"

--Shop/Inventory/Storage Admin Items
LANGUAGE.item_name_money                     = "Money"
LANGUAGE.item_desc_money                     = "DO NOT BUY!"
LANGUAGE.item_name_mixedherb1                = "Mixed Herb R/G"
LANGUAGE.item_desc_mixedherb1                = "Heals Decent wounds"
LANGUAGE.item_name_mixedherb2                = "Mixed Herb R/G/B"
LANGUAGE.item_desc_mixedherb2                = "Heals and Removes Everything"
LANGUAGE.item_name_mixedherb3                = "Mixed Herb G/G"
LANGUAGE.item_desc_mixedherb3                = "Heals Decent wounds"
LANGUAGE.item_name_mixedherb4                = "Mixed Herb G/G/G"
LANGUAGE.item_desc_mixedherb4                = "Heals Complete With Overshield"

--Perks
LANGUAGE.item_name_perk_immunity             = "Immunity"
LANGUAGE.item_desc_perk_immunity             = "Can not be infected when damaged"
LANGUAGE.item_name_perk_headhunter           = "Head Hunter"
LANGUAGE.item_desc_perk_headhunter           = "Regenerate 5 HP for every kill"
LANGUAGE.item_name_perk_combattraining       = "Combat Training"
LANGUAGE.item_desc_perk_combattraining       = "Gain Movement Speed"
LANGUAGE.item_name_perk_resilience           = "Resilience"
LANGUAGE.item_desc_perk_resilience           = "Take 25% less damage"
LANGUAGE.item_name_perk_beginnerluck         = "Beginner's Luck"
LANGUAGE.item_desc_perk_beginnerluck         = "Gain 100% more health but gain 75% less money"
LANGUAGE.item_name_perk_doubletap            = "Double Tap"
LANGUAGE.item_desc_perk_doubletap            = "Shoot 2 Shots Instead Of 1"
LANGUAGE.item_name_perk_explosivesexpert     = "Explosives Expert"
LANGUAGE.item_desc_perk_explosivesexpert     = "Explosives have a bigger radius and are more powerful"
LANGUAGE.item_name_perk_fasthands            = "Fast Hands"
LANGUAGE.item_desc_perk_fasthands            = "Reload and Shoot twice as fast"
LANGUAGE.item_name_perk_engineer            = "Engineer"
LANGUAGE.item_desc_perk_engineer            = "Repair Barricades & More Health"








