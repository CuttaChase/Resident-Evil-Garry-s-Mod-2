GM.Config = {}





----Merchant/Inventory/Storage
GM.Config.MaxStorageSlots = 30
GM.Config.InitialStorageSlots = 3
GM.Config.InventorySlotPrice = 10000
GM.Config.StorageSlotPrice = 2000
GM.Config.SalePercent = 0.1
GM.Config.StartingMoney = 500

----Zombies
GM.Config.MaxZombies = 25 -- 22 is default : Higher Values will result in more lag. ADJUST WITH CAUTION
GM.Config.ZombieSpawnTime = 6 -- !DO NOT ADJUST!

----Saving
GM.Config.SaveFrequency = 15
GM.Config.RagdollFrequency = 60
----Ammo Max
GM.Config.PistolAmmoMax = 150
GM.Config.MagumAmmoMax = 72
GM.Config.ShotgunAmmoMax = 35
GM.Config.AutomaticAmmoMax = 200
GM.Config.RifleAmmoMax = 135
GM.Config.MinigunAmmoMax = 600
GM.Config.RPGAmmoMax = 5
GM.Config.GrenadeAmmoMax = 7
GM.Config.SniperAmmoMax = 60

----Merchant Time
GM.Config.MerchantTime = 120
GM.Config.VotingTime = 55

----ZombieHealth
GM.Config.ZombieMaxHealth = 400
GM.Config.ZombieHealth = 50


----Reward Money
GM.Config.Escape = 300
GM.Config.Boss = 300
GM.Config.Doom = 2500

GM.Config.MerchantOpen = {
	"06_goodthingsonsale.wav",
	"08_whatayabuyin.wav",
	"18_welcome.wav",
}

GM.Config.MerchantClose = {
	"04_isthatall.wav",
	"16_comebackanytime.wav",
}

GM.Config.MerchantBuy = {
	"01_thankyou.wav",
	"12_handcannon.wav",
}

itemtypes = {
["item_c4"] = "C4",
["item_landmine"] = "Landmine",
["item_decoy"] = "Decoy Bomb",
["item_crate"] = "Crate",
["item_rammo"] = "Rifle Ammo",
["item_pammo"] = "Pistol Ammo",
["item_gherb"] = "Green Herb",
["item_bherb"] = "Blue Herb",
["item_rherb"] = "Red Herb",
["item_money"] = "Money",
["item_tcure"] = "T-Virus Cure",
["item_spray"] = "Health Spray",
["item_mammo"] = "SMG Ammo",
["item_3ammo"] = "Magnum Ammo",
["item_bammo"] = "Shotgun Ammo",
["item_mixedherb1"] = "G+R Herb",
["item_mixedherb2"] = "R+G+B Herb",
["item_mixedherb3"] = "G+G Herb",
["item_mixedherb4"] = "G+G+G Herb",
["item_barricade"] = "Barricade",
}
weapontypes = {
	["item_1873"]="1897",
	["item_1873"]="1873",
	["item_bauto5"]="Browning Auto-5",
	["item_bhp"]="BHP",
	["item_c96"]="C96",
	["item_colt"]="Colt",
	["item_fal"]="FAL",
	["item_g3"]="G3",
	["item_fnc"]="FNC",
	["item_gyrojet"]="GyroJet",
	["item_m3r"]="M3R",
	["item_m14"]="M14",
	["item_m16"]="M16",
	["item_m49"]="M49",
	["item_m60"]="M60",
	["item_m1921"]="M1921",
	["item_mk22"]="MK22",
	["item_mp5sd"]="MP5SD",
	["item_mp40"]="MP40",
	["item_rpk"]="RPK"
}

zombtable = {
	["snpc_shambler"] = "Shambler",
 	["snpc_zombie_dog"] = "Zombie Dog",
	["snpc_zombie_nemesis"] = "Nemesis"
}
-- Money values for zombie kills


---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------


AmmoMax = {}
AmmoMax["pistol"] = GM.Config.PistolAmmoMax
AmmoMax["ar2"] = GM.Config.RifleAmmoMax
AmmoMax["smg1"] = GM.Config.AutomaticAmmoMax
AmmoMax["none"] = 0
AmmoMax["buckshot"] = GM.Config.ShotgunAmmoMax
AmmoMax["357"] = GM.Config.MagumAmmoMax
AmmoMax["CombineCannon"] = GM.Config.GrenadeAmmoMax
AmmoMax["GaussEnergy"] = GM.Config.GrenadeAmmoMax
AmmoMax["Battery"] = GM.Config.GrenadeAmmoMax
AmmoMax["StriderMinigun"] = GM.Config.MinigunAmmoMax
AmmoMax["RPG_Round"] = GM.Config.RPGAmmoMax
AmmoMax["XBowBolt"] = GM.Config.SniperAmmoMax


---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
--[[This Is How you will set your custom maps for certain
gamemodes.


re2_ = SURVIVOR/VIP/TEAMVIP/MERCENARIES/LASTMANSTANDING
re2e_ = ESCAPE
re2b_ = BOSS


]]





---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
--LEGACY MAPS




----------------------------------
MapListTable = {}

local maps = file.Find("maps/re2_*.bsp", "GAME")

for k, v in pairs( maps ) do

		local name = string.lower( string.gsub( v, ".bsp", "" ) )

		table.insert( MapListTable, name )

end

local lmaps = file.Find("maps/re_*.bsp", "GAME")

for k, v in pairs( lmaps ) do

		local name = string.lower( string.gsub( v, ".bsp", "" ) )

		table.insert( MapListTable, name )

end

EscapeListTable = {}

local emaps = file.Find("maps/re2e_*.bsp", "GAME")

for k, v in pairs( emaps ) do

		local name = string.lower( string.gsub( v, ".bsp", "" ) )

		table.insert( EscapeListTable, name )

end

BossListTable = {}

local bmaps = file.Find("maps/re2b_*.bsp", "GAME")

for k, v in pairs( bmaps ) do

	local name = string.lower( string.gsub( v, ".bsp", "" ) )

	table.insert( BossListTable, name )

end

GamemodeListTable = {
"Survivor",
"VIP",
"Boss",
"TeamVIP",
"Escape",
"Mercenaries",
"LastManStanding",
"Doom",

}


---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
--[[THIS IS WHERE YOU ADJUST DIFFICULTY OF THE GAME]]

--[[ItemChance = Lower means more items, Higher means less items
	ZombieHealth = Standard/Miniuim Health
	ZombieMaxHealth = Max Stanard Health
	Modifier = !!!NOTE: this is a modifier for money, zombie 
	health, etc. pretty much everything. adjusting this
	will change adjusters ingame. Do not touch!!!!]]

------------------------------
------------Default Difficulties----------------

GM.ZombieData2 = {}
GM.ZombieData2["Easy"] = {
	ItemChance = 60,
	ZombieHealth = 5,
	ZombieMaxHealth = 40,
	Modifier = 1,
}


------------------------------------------------
GM.ZombieData = {}
GM.ZombieData["Easy"] = {
	ItemChance = 60,
	ZombieHealth = 5,
	ZombieMaxHealth = 40,
	Modifier = 1,
}
GM.ZombieData["Normal"] = {
	ItemChance = 80,
	ZombieHealth = 20,
	ZombieMaxHealth = 80,
	Modifier = 2,
}
GM.ZombieData["Difficult"] = {
	ItemChance = 100,
	ZombieHealth = 80,
	ZombieMaxHealth = 160,
	Modifier = 3,
}
GM.ZombieData["Expert"] = {
	ItemChance = 120,
	ZombieHealth = 160,
	ZombieMaxHealth = 300,
	Modifier = 4,
}
GM.ZombieData["Suicidal"] = {
	ItemChance = 140,
	ZombieHealth = 300,
	ZombieMaxHealth = 500,
	Modifier = 5,
}



function GM:SpawningZombies()

	if GetGlobalString("Mode") == "On" && (GetGlobalString("RE2_Game") != "Boss") then



		for j,h in pairs(ents.FindByClass("ent_zombie_spawn")) do
			if !h.Disabled then


				local Blocked = false
				for k,v in pairs(ents.FindInSphere(h:GetPos(),100)) do
					if v:GetClass() == "snpc_shambler" or v:GetClass() == "snpc_zombie_dog" or v:GetClass() == "snpc_zombie_nemesis" or v:GetClass() == "snpc_shambler_fast" then
						Blocked = true
					end
				end
					local diffadjust1 = (table.Count( player.GetAll()) * 15)
					local diffadjust2 = (GAMEMODE.ZombieData[GetGlobalString("RE2_Difficulty")].Modifier * 50)
					--local Chance = math.random(0,(950 - ( diffadjust2 + diffadjust1 ) ) )
					local Chance = math.random(0,(950 - ( diffadjust1 ) ) )
					local minichance = math.random(0,2000)

					--[[
						-----------
						----DLC----
						-----------
					]]
					-----------------------------------------




					-----------------------------------------
					--[[
						-----------
						----DLC----
						-----------

					--[[

					

					]]


					if NumZombies <= GAMEMODE.Config.MaxZombies then
						if minichance >= 1950 && Chance <= 400 && !Blocked then
							local ent = ents.Create("snpc_zombie_dog") --GAMEMODE.ZombieData.Zombies[math.random(1,#GAMEMODE.ZombieData.Zombies)])
							local min = GAMEMODE.ZombieData[GetGlobalString("RE2_Difficulty")].ZombieHealth / 5
							local max = GAMEMODE.ZombieData[GetGlobalString("RE2_Difficulty")].ZombieMaxHealth / 5
							ent:SetHealth(math.random(min, max + (table.Count( player.GetAll()) * 20) ))
							ent:SetPos(h:GetPos())
							ent:Spawn()
							NumZombies = NumZombies + 1
						end
					end

					if NumZombies <= GAMEMODE.Config.MaxZombies - 2 then
						if !Blocked && Chance <= 400 then
							local ent = ents.Create("snpc_shambler") --GAMEMODE.ZombieData.Zombies[math.random(1,#GAMEMODE.ZombieData.Zombies)])
							local min = GAMEMODE.ZombieData[GetGlobalString("RE2_Difficulty")].ZombieHealth 
							local max = GAMEMODE.ZombieData[GetGlobalString("RE2_Difficulty")].ZombieMaxHealth 
							ent:SetHealth(math.random(min, max + (table.Count( player.GetAll()) * 20) ))
							ent:SetPos(h:GetPos())
							ent:Spawn()
							NumZombies = NumZombies + 1
						end
					end
					

					if NumZombies <= GAMEMODE.Config.MaxZombies then
						if minichance <= 50 && Chance <= 400 && !Blocked then
							local ent = ents.Create("snpc_shambler_fast") --GAMEMODE.ZombieData.Zombies[math.random(1,#GAMEMODE.ZombieData.Zombies)])
							local min = GAMEMODE.ZombieData[GetGlobalString("RE2_Difficulty")].ZombieHealth / 2
							local max = GAMEMODE.ZombieData[GetGlobalString("RE2_Difficulty")].ZombieMaxHealth / 2
							ent:SetHealth(math.random(min, max + (table.Count( player.GetAll()) * 20) ))
							ent:SetPos(h:GetPos())
							ent:Spawn()
							NumZombies = NumZombies + 1
						end
					end

					if NumZombies <= GAMEMODE.Config.MaxZombies then
						if minichance == 11 && Chance <= 400 && !Blocked then
							local ent = ents.Create("snpc_zombie_nemesis") --GAMEMODE.ZombieData.Zombies[math.random(1,#GAMEMODE.ZombieData.Zombies)])
							local min = GAMEMODE.ZombieData[GetGlobalString("RE2_Difficulty")].ZombieHealth
							local max = GAMEMODE.ZombieData[GetGlobalString("RE2_Difficulty")].ZombieMaxHealth
							ent:SetHealth(math.random(min, max + (table.Count( player.GetAll()) * 100) ))
							ent:SetPos(h:GetPos())
							ent:Spawn()
							NumZombies = NumZombies + 1
						end
					end


					

			end
		end

	end

end


function GM:SpawningZombies2()

	if GetGlobalString("Mode") == "On" && (GetGlobalString("RE2_Game") == "Boss") then


		for j,h in pairs(ents.FindByClass("ent_zombie_spawn")) do
			if !h.Disabled then


				local Blocked = false
				for k,v in pairs(ents.FindInSphere(h:GetPos(),100)) do
					if v:GetClass() == "snpc_shambler2" or v:GetClass() == "snpc_zombie_dog2" or v:GetClass() == "snpc_zombie_nemesis" then
						Blocked = true
					end
				end
				local diffadjust1 = (table.Count( player.GetAll()) * 15)
				local diffadjust2 = (GAMEMODE.ZombieData[GetGlobalString("RE2_Difficulty")].Modifier * 50)
				--local Chance = math.random(0,(950 - ( diffadjust2 + diffadjust1 ) ) )
				local Chance = math.random(0,(950 - ( diffadjust1 ) ) )
				local minichance = math.random(0,2000)

				--[[
					-----------
					----DLC----
					-----------
				]]
				-----------------------------------------




				-----------------------------------------
				--[[
					-----------
					----DLC----
					-----------

				--[[

				

				]]


				if NumZombies <= GAMEMODE.Config.MaxZombies then
					if minichance >= 1800 && Chance <= 400 && !Blocked then
						local ent = ents.Create("snpc_zombie_dog2") --GAMEMODE.ZombieData.Zombies[math.random(1,#GAMEMODE.ZombieData.Zombies)])
						local min = GAMEMODE.ZombieData[GetGlobalString("RE2_Difficulty")].ZombieHealth / 5
						local max = GAMEMODE.ZombieData[GetGlobalString("RE2_Difficulty")].ZombieMaxHealth / 5
						ent:SetHealth(math.random(min, max + (table.Count( player.GetAll()) * 20) ))
						ent:SetPos(h:GetPos())
						ent:Spawn()
						NumZombies = NumZombies + 1
					end
				end

				if NumZombies <= GAMEMODE.Config.MaxZombies - 2 then
					if !Blocked && Chance <= 400 then
						local ent = ents.Create("snpc_shambler2") --GAMEMODE.ZombieData.Zombies[math.random(1,#GAMEMODE.ZombieData.Zombies)])
						local min = GAMEMODE.ZombieData[GetGlobalString("RE2_Difficulty")].ZombieHealth 
						local max = GAMEMODE.ZombieData[GetGlobalString("RE2_Difficulty")].ZombieMaxHealth 
						ent:SetHealth(math.random(min, max + (table.Count( player.GetAll()) * 20) ))
						ent:SetPos(h:GetPos())
						ent:Spawn()
						NumZombies = NumZombies + 1
					end
				end


				

		end
	end

end

end

---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------



GM.Music = {
	Safe = {
				{Sound = "/residentevil/hope_re.mp3", Length = 90},
				{Sound = "/residentevil/fronthall_re.mp3", Length = 90},
				{Sound = "/residentevil/safe_re.mp3", Length = 90},
				{Sound = "/residentevil/library_re.mp3", Length = 90},
				{Sound = "/residentevil/fronthall_re.mp3", Length = 90},
			},
	Battle = {
				{Sound = "/residentevil/escape_re.mp3", Length = 90},
				{Sound = "/residentevil/boss_re.mp3", Length = 90},
				{Sound = "/residentevil/raccoon_re.mp3", Length = 90},
				{Sound = "/residentevil/attack_re.mp3", Length = 90},
			},
	End = {
			{Sound = "/reg/Results_01.mp3", Length = 120},
			{Sound = "/reg/Results_02.mp3", Length = 94},
			{Sound = "/reg/ree_theme.mp3", Length = 125},
			},
	}




---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------


function HoveringNames()

	for k, v in pairs (ents.GetAll()) do
		if v:GetClass() == "snpc_zombie_nemesis" or v:GetClass() == "drg_roach_jack" or v:GetClass() == "drg_roach_swampman" or v:GetClass() == "drg_roach_re2_g1" then
			local targetPos = v:GetPos() + Vector(0,0,84)
			local tt = v:GetPos() + Vector(0,0,100)
			local targetDistance = math.floor((LocalPlayer():GetPos():Distance( targetPos ))/40)
			local targetScreenpos = targetPos:ToScreen()
			local ttscreen = tt:ToScreen()
			draw.SimpleText(v:Health(), "Trebuchet18", tonumber(targetScreenpos.x), tonumber(ttscreen.y), Color(200,25,25,200), TEXT_ALIGN_CENTER)
		end
	end
end
hook.Add("HUDPaint", "HoveringNames", HoveringNames)






















---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------



--Game mode list
GM.Gamemode = {}
	GM.Gamemode["Survivor"] = {


		PrepFunction = function()

			SetGlobalString( "Mode", "prep" )
			GAMEMODE:SelectMusic(GetGlobalString("Mode"))

			SetGlobalInt("Re2_CountDown", 30)
			timer.Create("Re2_CountDowntimer_Survivor",1,0, function()
			SetGlobalInt("Re2_CountDown", GetGlobalInt("Re2_CountDown") - 1)
				if GetGlobalInt("Re2_CountDown") <= 0 then
					GAMEMODE:BaseStart()
					timer.Destroy("Re2_CountDowntimer_Survivor")
				end
			end	)
		end,

		StartFunction = function()
							
							local difficultyadjust = GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier * 50
							local playeradjust = table.Count(team.GetPlayers(TEAM_HUNK)) * 15
							local togetheradjust = playeradjust + difficultyadjust
							local modifier = togetheradjust
							SetGlobalInt("DeadZombieKillNumber", GetGlobalInt("DeadZombieKillNumber") + modifier)
							timer.Create("TimeSurvivedTimer",1,0, function()
							SetGlobalInt("RE2_GameTime", GetGlobalInt("RE2_GameTime") + 1)

							for _,ply in pairs(team.GetPlayers(TEAM_HUNK)) do
								ply:SetNWInt("Time",ply:GetNWInt("Time") + 1 )
							end

								if GetGlobalInt("RE2_DeadZombies") >= GetGlobalInt("DeadZombieKillNumber") && GetGlobalInt("Game") != "End" then
									timer.Destroy("TimeSurvivedTimer")
									GAMEMODE:BaseEndGame()
								end
							end )

						end,

		CheckFunction = function()
							if team.NumPlayers(TEAM_HUNK) <= 0 then
								GAMEMODE:BaseEndGame()
								return
							end
						end,

		EndFunction = function()
						if GetGlobalInt("RE2_DeadZombies") >= GetGlobalInt("DeadZombieKillNumber") then
							if table.Count(team.GetPlayers(TEAM_HUNK)) > 0 then
								for _,ply in pairs(player.GetAll()) do
									if ply:Team() == TEAM_HUNK then
										ply:SetNWBool("Infected", false)
										ply:SetNWInt("InfectedPercent", 0)

										ply:DeathReward()

									end
								end
							end
						end
					end,
		RewardFunction = function()
				if GetGlobalInt("RE2_DeadZombies") >= GetGlobalInt("DeadZombieKillNumber") then
					if table.Count(team.GetPlayers(TEAM_HUNK)) > 0 then
						local reward = table.Count(team.GetPlayers(TEAM_HUNK)) * 150
						reward = reward * GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier
						PrintTranslatedMessage( HUD_PRINTTALK, "survived", reward)
						for _,ply in pairs(player.GetAll()) do
							Save(ply)
							if ply:Team() == TEAM_HUNK then

							ply:SetNWInt("Money", ply:GetNWInt("Money") + reward )

							end
						end
					end
				end
		end,
	}

	GM.Gamemode["LastManStanding"] = {
		Condition = function()
			if team.NumPlayers(TEAM_HUNK) <= 3 then
				return false
			end
			return true
		end,

		PrepFunction = function()

			SetGlobalString( "Mode", "prep" )
			GAMEMODE:SelectMusic(GetGlobalString("Mode"))

			SetGlobalInt("Re2_CountDown", 60)
			timer.Create("Re2_CountDowntimer_Survivor",1,0, function()
			SetGlobalInt("Re2_CountDown", GetGlobalInt("Re2_CountDown") - 1)
				if GetGlobalInt("Re2_CountDown") <= 0 then
					GAMEMODE:BaseStart()
					timer.Destroy("Re2_CountDowntimer_Survivor")
				end
			end	)

		end,

		StartFunction = function()


							timer.Create("TimeSurvivedTimer",1,0, function()
							SetGlobalInt("RE2_GameTime", GetGlobalInt("RE2_GameTime") + 1)

							for _,ply in pairs(team.GetPlayers(TEAM_HUNK)) do
								ply:SetNWInt("Time",ply:GetNWInt("Time") + 1 )
							end

								if table.Count(team.GetPlayers(TEAM_HUNK)) == 1 && GetGlobalInt("Game") != "End" then
									timer.Destroy("TimeSurvivedTimer")
									GAMEMODE:BaseEndGame()
								end
							end )

						end,

		CheckFunction = function()
							if table.Count(team.GetPlayers(TEAM_HUNK)) == 1 then
								GAMEMODE:BaseEndGame()
								return
							end
						end,

		EndFunction = function()
						if table.Count(team.GetPlayers(TEAM_HUNK)) == 1 then
							if table.Count(team.GetPlayers(TEAM_HUNK)) > 0 then
								for _,ply in pairs(player.GetAll()) do
									Save(ply)
									if ply:Team() == TEAM_HUNK then
										ply:SetNWBool("Infected", false)
										ply:SetNWInt("InfectedPercent", 0)

										ply:DeathReward()

									end
								end
							end
						end
					end,
		DifficultyFunction = function() -- Called Every 60 seconds
			if !GetGlobalBool("Re2_Classic") then
				GAMEMODE.ZombieDatafast = GAMEMODE.ZombieDatafast + 1
				//table.insert(GAMEMODE.ZombieData.Zombies,"snpc_zombie_crimzon")
			end
		end,
		RewardFunction = function()
				if table.Count(team.GetPlayers(TEAM_HUNK)) == 1 then
					if table.Count(team.GetPlayers(TEAM_HUNK)) > 0 then
						local reward = table.Count(team.GetPlayers(TEAM_HUNK)) * 300
						reward = reward * GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier * 2
						PrintMessage( HUD_PRINTTALK, "Last Person Alive won "..reward.." Well done!" )
						for _,ply in pairs(player.GetAll()) do
							Save(ply)
							if ply:Team() == TEAM_HUNK then

							ply:SetNWInt("Money", ply:GetNWInt("Money") + reward )

							end
						end
					end
				end
		end,
		}

	GM.Gamemode["VIP"] = {

		Condition = function()
			if team.NumPlayers(TEAM_HUNK) <= 1 then
				return false
			end
			return true
		end,

		DisconnectFunction = function(ply)
				if GetGlobalString("Mode") != "End" then
					if GetGlobalEntity("Thevip") == ply && team.NumPlayers(TEAM_HUNK) > 1 then
						local hunks = team.GetPlayers(TEAM_HUNK)
						local VIP = team.GetPlayers(TEAM_HUNK)[math.random(1,#hunks)]
						SetGlobalEntity( "Thevip", VIP  )
						VIP:Give("weapon_physcannon")
					elseif team.NumPlayers(TEAM_HUNK) < 1 then
						GAMEMODE:BaseEndGame()
					end
				end
			end,
		PrepFunction = function()

			SetGlobalString( "Mode", "prep" )
			GAMEMODE:SelectMusic(GetGlobalString("Mode"))

			SetGlobalInt("Re2_CountDown", 15)
			------------------Choose Vip
			SetGlobalEntity( "Thevip", ""  )
			local hunks = team.GetPlayers(TEAM_HUNK)
			local VIP = team.GetPlayers(TEAM_HUNK)[math.random(1,#hunks)]
			SetGlobalEntity( "Thevip", VIP  )
			VIP:Give("weapon_physcannon")

			timer.Create("Re2_CountDowntimer_Vip",1,0, function()
			SetGlobalInt("Re2_CountDown", GetGlobalInt("Re2_CountDown") - 1)
				if GetGlobalInt("Re2_CountDown") <= 0 then
					GAMEMODE:BaseStart()
					timer.Destroy("Re2_CountDowntimer_Vip")
				end

			end
			)
		end,

		StartFunction = function()
		SetGlobalInt("Re2_CountDown", 300 + (table.Count(team.GetPlayers(TEAM_HUNK)) * 60) )

		---------------------Set the Re2_CountDown
				timer.Create("Re2_CountDownVIP",1,0, function()

						SetGlobalInt("RE2_GameTime", GetGlobalInt("RE2_GameTime") + 1)
						SetGlobalInt("Re2_CountDown", GetGlobalInt("Re2_CountDown") - 1)
							for _,ply in pairs(team.GetPlayers(TEAM_HUNK)) do
								ply:SetNWInt("Time",ply:GetNWInt("Time") + 1 )
							end
							if GetGlobalInt("Re2_CountDown") <= 0 then
								timer.Destroy("Re2_CountDownVIP")
								GAMEMODE:BaseEndGame()
							end
					end)

		end,

		CheckFunction = function()
					if GetGlobalEntity("Thevip"):Team() != TEAM_HUNK && GetGlobalEntity("Thevip") != nil then
						GAMEMODE:BaseEndGame()
						return
					elseif GetGlobalEntity("Thevip") == nil then
						GAMEMODE:BaseEndGame()
					end
		end,

		EndFunction = function()
				for _,ply in pairs(player.GetAll()) do
					Save(ply)
					if ply:Team() == TEAM_HUNK then
						ply:SetNWBool("Infected", false)
						ply:SetNWInt("InfectedPercent", 0)

						ply:DeathReward()

					end
				end
				timer.Destroy("Re2_CountDowntimer")
			end,

			DifficultyFunction = function()
				if !GetGlobalBool("Re2_Classic") then
					GAMEMODE.ZombieDatafast = GAMEMODE.ZombieDatafast + 1
					//table.insert(GAMEMODE.ZombieData.Zombies,"snpc_zombie_crimzon")
				end
			end,

		RewardFunction = function()
			local leader = player.GetAll()[1]
			if GetGlobalEntity( "Thevip", VIP  ):Team() == TEAM_HUNK then
				local reward = math.Round((GetGlobalInt("RE2_DeadZombies") * math.Round(table.Count( player.GetAll())))/ 2)
				reward = reward * GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier * 2
				PrintTranslatedMessage( HUD_PRINTTALK, "vip_survived", reward )
				for _,ply  in pairs(player.GetAll()) do
					ply:SetNWInt("Money",math.Round(ply:GetNWInt("Money")+ reward))
					Save(ply)
				end
			else
				PrintTranslatedMessage( HUD_PRINTTALK, "vip_died" )
			end
		end,


		HudFunction = function(ply)
			if SERVER then return end
			local SW = ScrW()
			local SH = ScrH()
			local client = LocalPlayer()
			if GetGlobalString("RE2_Game") == "VIP" && GetGlobalString("Mode") != "Merchant" then
				if ply != GetGlobalEntity("Thevip") && GetGlobalEntity("Thevip"):Team() == TEAM_HUNK then
					local Vipcolor = Color(0,155,0,250)
					if GetGlobalEntity("Thevip"):Health() >= 75 then
							Vipcolor = Color(0,155,0,250)
						elseif GetGlobalEntity("Thevip"):Health() >= 51 and GetGlobalEntity("Thevip"):Health() <= 74 then
							Vipcolor = Color(155,155,0,250)
						elseif GetGlobalEntity("Thevip"):Health() >= 20 and GetGlobalEntity("Thevip"):Health() <= 50 then
							Vipcolor = Color(155,100,0,250)
						elseif GetGlobalEntity("Thevip"):Health() <= 19 then
							Vipcolor = Color(155,0,0,250)
						end
					local min,max,cen = GetGlobalEntity("Thevip"):LocalToWorld(GetGlobalEntity("Thevip"):OBBMins()), GetGlobalEntity("Thevip"):LocalToWorld(GetGlobalEntity("Thevip"):OBBMaxs()), GetGlobalEntity("Thevip"):LocalToWorld(GetGlobalEntity("Thevip"):OBBCenter())
					local minl,maxl,cenp = min:Distance(cen), max:Distance(cen), cen:ToScreen()
					local minp = (cen + (ply:GetRight() * (-1 * minl)) + (ply:GetUp() * (-1 * minl))):ToScreen()
					local maxp = (cen + (ply:GetRight() * maxl) + (ply:GetUp() * maxl)):ToScreen()
					if not cenp.visible then
						DrawTime = nil
					return end
					surface.SetDrawColor(Vipcolor)
					surface.DrawLine(minp.x,maxp.y,maxp.x,maxp.y)
					surface.DrawLine(minp.x,maxp.y,minp.x,minp.y)
					surface.DrawLine(minp.x,minp.y,maxp.x,minp.y)
					surface.DrawLine(maxp.x,maxp.y,maxp.x,minp.y)
					surface.SetDrawColor(255,255,255,155)
					surface.SetTextPos(minp.x+2,maxp.y-15)
					local text = translate.Get("protect_vip")
					surface.SetFont("DefaultSmall")
					surface.DrawText(text)
					surface.SetDrawColor(255,255,255,255)
					surface.SetTextPos(minp.x+2,maxp.y-15)
					surface.SetFont("Default")
					surface.DrawText(text)
				elseif ply == GetGlobalEntity("Thevip") && GetGlobalEntity("Thevip"):Team() == TEAM_HUNK then
					surface.SetFont("Trebuchet18o")
					local textx,texty = surface.GetTextSize(translate.Get("you_vip"))
					draw.SimpleText(translate.Get("you_vip"),"Trebuchet18o",SW/2 - textx/2,SH - SH + 60,Color(255,255,255,255),0,0)
					DrawIcon(surface.GetTextureID("gui/silkicons/star" ),SW/2 - 8, SH - SH + 36 ,16,16)
				end
			end
		end,
		}

	GM.Gamemode["Mercenaries"] = {
		Condition = function()
			if team.NumPlayers(TEAM_HUNK) <= 1 then
				return false
			end
			return true
		end,

		PrepFunction = function()
			GAMEMODE:BaseStart()
		end,


		StartFunction = function()
			GAMEMODE.Zombies = {
			"snpc_zombie",
			"snpc_zombie_crimzon",
			"snpc_zombie_crimzon",
			"snpc_zombie_crimzon",
			"snpc_zombie_crimzon",
			"snpc_zombie_crimzon",
			"snpc_zombie_crimzon",
			"snpc_zombie_crimzon",
			}
			SetGlobalInt("Re2_CountDown", 180)
			timer.Create("Re2_CountDownMercenaries",1,0, function()
						SetGlobalInt("RE2_GameTime", GetGlobalInt("RE2_GameTime") + 1)
						SetGlobalInt("Re2_CountDown", GetGlobalInt("Re2_CountDown") - 1)
						if GetGlobalInt("Re2_CountDown") <= 0 then
							timer.Destroy("Re2_CountDownMercenaries")
							GAMEMODE:BaseEndGame()
							end
						end)
			end,

		CheckFunction = function()
			if team.NumPlayers(TEAM_HUNK) <= 0 then
				GAMEMODE:BaseEndGame()
				return
			end
		end,

		EndFunction = function()
			timer.Destroy("Re2_CountDownMercenaries")
		end,

		DifficultyFunction = function()
			if !GetGlobalBool("Re2_Classic") then
				GAMEMODE.ZombieDatafast = GAMEMODE.ZombieDatafast + 1
				//table.insert(GAMEMODE.ZombieData.Zombies,"snpc_zombie_crimzon")
			end
		end,

		RewardFunction = function()
			local leader = table.Random(player.GetAll())
			for _,ply in pairs(player.GetAll()) do
				Save(ply)
				if ply:GetNWInt("killcount") >= leader:GetNWInt("killcount")  && ply != leader then
					leader = ply
				end
					if ply:Team() == TEAM_HUNK then
						ply:SetNWBool("Infected", false)
						ply:SetNWInt("InfectedPercent", 0)

						ply:DeathReward()

					end
			end
			local reward = table.Count(player.GetAll())*250
			reward = reward * GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier
			--PrintTranslatedMessage( HUD_PRINTTALK, leader:Nick(), "won", reward )
			PrintMessage( HUD_PRINTTALK, "The Winner Is " ..leader:Nick().. " And Won " ..reward..". Well done!" )
			leader:SetNWInt("Money", leader:GetNWInt("Money") + (math.Round(table.Count(player.GetAll())*350)))
		end,
		}

	GM.Gamemode["Boss"] = {
		Condition = function()
			if team.NumPlayers(TEAM_HUNK) <= 1 then
				return false
			end
			return true
		end,

		PrepFunction = function()
			SetGlobalString( "Mode", "prep" )
			GAMEMODE:SelectMusic(GetGlobalString("Mode"))

			SetGlobalInt("Re2_CountDown", 60)
			timer.Create("Re2_CountDowntimer_Boss",1,0, function()
			SetGlobalInt("Re2_CountDown", GetGlobalInt("Re2_CountDown") - 1)
				if GetGlobalInt("Re2_CountDown") <= 0 then
					GAMEMODE:BaseStart()
					timer.Destroy("Re2_CountDowntimer_Boss")
				end
			end	)
		end,


		StartFunction = function()
			SetGlobalInt("RE2_DeadZombies",GetGlobalInt("RE2_DeadZombies") + 1)
            PrintTranslatedMessage(HUD_PRINTTALK, "boss_appeared")

            local Zombie = {
				"snpc_zombie_nemesis",
			}
			--[[

			This is for any new boss nextbots that i can find.
			hopefully they are killable and will need special
			properties for balancing

			------------Addon Bosses------------------


			]]
			
					
			--------------------------------------------	

            local ent = ents.Create(table.Random(Zombie))
            ent:SetPos(table.Random(ents.FindByClass("ent_zombie_spawn")):GetPos())
            ent:Spawn()
			
			local min = ( GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier )+table.Count(player.GetAll())*1500
			local max = ( GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier )+table.Count(player.GetAll())*3200
			ent:SetHealth(math.random(min, max ) )
			SetGlobalInt("Re2_CountDown", 600)
			timer.Create("Re2_CountDownMercenaries",1,0, function()
						SetGlobalInt("RE2_GameTime", GetGlobalInt("RE2_GameTime") + 1)
						SetGlobalInt("Re2_CountDown", GetGlobalInt("Re2_CountDown") - 1)
						if GetGlobalInt("Re2_CountDown") <= 0 then
							timer.Destroy("Re2_CountDownMercenaries")
							GAMEMODE:BaseEndGame()
						end
						if (GetGlobalString("RE2_Game") == "Boss") && GetGlobalInt("RE2_DeadZombies") >= 5 then
							timer.Destroy("Re2_CountDownMercenaries")
							GAMEMODE:BaseEndGame()
						end
						end)
			end,

		CheckFunction = function()
			if team.NumPlayers(TEAM_HUNK) <= 0 then
				GAMEMODE:BaseEndGame()
				return
			end
		end,

		EndFunction = function()
			timer.Destroy("Re2_CountDownMercenaries")
		end,

		DifficultyFunction = function()
			if !GetGlobalBool("Re2_Classic") then
				GAMEMODE.ZombieDatafast = GAMEMODE.ZombieDatafast + 1
				//table.insert(GAMEMODE.ZombieData.Zombies,"snpc_zombie_crimzon")
			end
		end,

		RewardFunction = function()
			local reward = math.Round( #player.GetAll() * GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier * GAMEMODE.Config.Boss )
			if (GetGlobalString("RE2_Game") == "Boss") && GetGlobalInt("RE2_DeadZombies") >= 2 then
				PrintTranslatedMessage( HUD_PRINTTALK, "boss_killed", reward )
				for k,v in pairs(player.GetAll()) do
					v:SetNWInt("Money",v:GetNWInt("Money",0)+reward)
					Save(v)
				end
			else
				PrintTranslatedMessage( HUD_PRINTTALK, "boss_not_killed" )
			end
			end,
		}

		GM.Gamemode["Doom"] = {


			PrepFunction = function()

				SetGlobalString( "Mode", "prep" )
				GAMEMODE:SelectMusic(GetGlobalString("Mode"))

				SetGlobalInt("Re2_CountDown", 60)
				timer.Create("Re2_CountDowntimer_Survivor",1,0, function()
				SetGlobalInt("Re2_CountDown", GetGlobalInt("Re2_CountDown") - 1)
					if GetGlobalInt("Re2_CountDown") <= 0 then
						GAMEMODE:BaseStart()
						timer.Destroy("Re2_CountDowntimer_Survivor")
					end
				end	)
			end,

			StartFunction = function()
								
								local difficultyadjust = GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier * 100
								local playeradjust = table.Count(team.GetPlayers(TEAM_HUNK)) * 15
								local togetheradjust = playeradjust + difficultyadjust
								local modifier = togetheradjust
								SetGlobalInt("DeadZombieKillNumber", GetGlobalInt("DeadZombieKillNumber") + modifier)
								PrintMessage(HUD_PRINTTALK, "Kill Enough Zombies To Win!" )
								local Zombie = {
									"snpc_zombie_nemesis",
								}
								

								local ent = ents.Create(table.Random(Zombie))
								ent:SetPos(table.Random(ents.FindByClass("ent_zombie_spawn")):GetPos())
								ent:Spawn()
								local min = ( GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier * table.Count(player.GetAll()) )*8000000000
								local max = ( GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier * table.Count(player.GetAll()) )*20000000000
								ent:SetHealth(math.random(min*table.Count(player.GetAll()), max*table.Count(player.GetAll())))


								timer.Create("TimeSurvivedTimer",1,0, function()
								SetGlobalInt("RE2_GameTime", GetGlobalInt("RE2_GameTime") + 1)

								for _,ply in pairs(team.GetPlayers(TEAM_HUNK)) do
									ply:SetNWInt("Time",ply:GetNWInt("Time") + 1 )
								end

									if GetGlobalInt("RE2_DeadZombies") >= GetGlobalInt("DeadZombieKillNumber") && GetGlobalInt("Game") != "End" then
										timer.Destroy("TimeSurvivedTimer")
										GAMEMODE:BaseEndGame()
									end
								end )

							end,

			CheckFunction = function()
								if team.NumPlayers(TEAM_HUNK) <= 0 then
									GAMEMODE:BaseEndGame()
									return
								end
							end,

			EndFunction = function()
							if GetGlobalInt("RE2_DeadZombies") >= GetGlobalInt("DeadZombieKillNumber") then
								if table.Count(team.GetPlayers(TEAM_HUNK)) > 0 then
									for _,ply in pairs(player.GetAll()) do
										if ply:Team() == TEAM_HUNK then
											ply:SetNWBool("Infected", false)
											ply:SetNWInt("InfectedPercent", 0)

											ply:DeathReward()

										end
									end
								end
							end
						end,
			RewardFunction = function()
					if GetGlobalInt("RE2_DeadZombies") >= GetGlobalInt("DeadZombieKillNumber") then
						if table.Count(team.GetPlayers(TEAM_HUNK)) > 0 then
							local reward = table.Count(team.GetPlayers(TEAM_HUNK)) * 100
							reward = math.Round( GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier * GAMEMODE.Config.Doom )
							PrintTranslatedMessage( HUD_PRINTTALK, "survived", reward)
							for _,ply in pairs(player.GetAll()) do
								Save(ply)
								if ply:Team() == TEAM_HUNK then

								ply:SetNWInt("Money", ply:GetNWInt("Money") + reward )

								end
							end
						end
					end
			end,
		}

	GM.Gamemode["Escape"] = {
		PrepFunction = function()
			GAMEMODE:BaseStart()
		end,

		StartFunction = function()
		timer.Create("TimeSurvivedTimer",1,0, function()
			SetGlobalInt("RE2_GameTime", GetGlobalInt("RE2_GameTime") + 1)
				for _,ply in pairs(team.GetPlayers(TEAM_HUNK)) do
					ply:SetNWInt("Time",ply:GetNWInt("Time") + 1 )
				end
			end)

		end,

		CheckFunction = function()
			if team.NumPlayers(TEAM_HUNK) <= 0 then
				GAMEMODE:BaseEndGame()
				return
			end
		end,

		EndFunction = function()

		end,
		DifficultyFunction = function()
			if !GetGlobalBool("Re2_Classic") then
				GAMEMODE.ZombieDatafast = GAMEMODE.ZombieDatafast + 1
				//table.insert(GAMEMODE.ZombieData.Zombies,"snpc_zombie_crimzon")
			end
		end,
		RewardFunction = function()
				if table.Count(team.GetPlayers(TEAM_HUNK)) > 0 then
				local reward = math.Round(GAMEMODE.Config.Escape * #player.GetAll())
				reward = reward * GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier
				PrintMessage( HUD_PRINTTALK, "You Have Escaped! Surviving players won $"..reward.." for staying alive. Well done!" )
				if team.NumPlayers(TEAM_HUNK) > 1 then
					local additionalreward = math.Round(GAMEMODE.Config.Escape / 3 * (team.NumPlayers(TEAM_HUNK) * GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier))
					PrintMessage( HUD_PRINTTALK, team.NumPlayers(TEAM_HUNK).." out of "..#player.GetAll().." survivors survived, every survivor gets a bonus of $"..additionalreward.." for team-work!" )
				end
				for _,ply in pairs(player.GetAll()) do
					Save(ply)
					if ply:Team() == TEAM_HUNK then
						ply:SetNWBool("Infected", false)
						ply:SetNWInt("InfectedPercent", 0)

						ply:DeathReward()
						if team.NumPlayers(TEAM_HUNK) > 1 then
							additionalreward = math.Round((reward/#player.GetAll())/team.NumPlayers(TEAM_HUNK))
							ply:SetNWInt("Money",math.Round(ply:GetNWInt("Money")+ reward + additionalreward))
						else
							ply:SetNWInt("Money",math.Round(ply:GetNWInt("Money")+ reward ))
						end

					end
				end
			end
		end,
		}

	GM.Gamemode["TeamVIP"] = {
		Name = "TeamVIP",
		Teams = true,
		Condition = function()
			if team.NumPlayers(TEAM_HUNK) <= 3 then
				return false
			end
			return true
		end,

		JoinFunction = function(ply)
			if GetGlobalString("Mode") != "Merchant" then
				if #Re2_Teams.StarsTeam <= #Re2_Teams.UmbrellaTeam then
					ply:SetNWInt("TeamId",1)
					table.insert(Re2_Teams.StarsTeam,ply)
				elseif #Re2_Teams.UmbrellaTeam <= #Re2_Teams.StarsTeam then
					ply:SetNWInt("TeamId",2)
					table.insert(Re2_Teams.StarsTeam,ply)
				end
			end
		end,

		DisconnectFunction = function(ply)
			if GetGlobalString("Mode") != "End" then
			if ply:GetNWInt("TeamId") == 1 then
				for key,data in pairs(Re2_Teams.StarsTeam) do
					if data == ply then
						table.remove(Re2_Teams.StarsTeam,key)
						break
					end
				end
			elseif ply:GetNWInt("TeamId") == 2 then
				for key,data in pairs(Re2_Teams.UmbrellaTeam) do
					if data == ply then
						table.remove(Re2_Teams.UmbrellaTeam,key)
						break
					end
				end
			end
				if GetGlobalEntity("Team01_VIP") == ply then
					local VIP = table.Random(Re2_Teams.StarsTeam)
					SetGlobalEntity( "Team01_VIP", VIP  )
					VIP:Give("weapon_physcannon")
				elseif GetGlobalEntity("Team02_VIP") == ply then
					local VIP = table.Random(Re2_Teams.UmbrellaTeam)
					SetGlobalEntity( "Team01_VIP", VIP  )
					VIP:Give("weapon_physcannon")
				end
			end
		end,

		PrepFunction = function()

			SetGlobalString( "Mode", "prep" )
			GAMEMODE:SelectMusic(GetGlobalString("Mode"))

			SetGlobalInt("Re2_CountDown", 15)

			Re2_Teams = {StarsTeam = {},UmbrellaTeam = {} }

			local SelectablePlayers = team.GetPlayers(TEAM_HUNK)

			for _,player in pairs(team.GetPlayers(TEAM_HUNK)) do
				if #Re2_Teams.UmbrellaTeam < #Re2_Teams.StarsTeam then
					local playa = table.Random(SelectablePlayers)
					playa:SetNWInt("TeamId",2)
					table.insert(Re2_Teams.UmbrellaTeam,playa)
					for key,data in pairs(SelectablePlayers) do
						if data == playa then
							table.remove(SelectablePlayers,key)
							break
						end
					end
				elseif #Re2_Teams.StarsTeam < math.Round(#team.GetPlayers(TEAM_HUNK)/2) then
					local plya = table.Random(SelectablePlayers)
					plya:SetNWInt("TeamId",1)
					table.insert(Re2_Teams.StarsTeam,plya)
					for key,data in pairs(SelectablePlayers) do
						if data == plya then
							table.remove(SelectablePlayers,key)
							break
						end
					end
				end
			end

			------------------Choose Vip
			PrintTable(Re2_Teams.StarsTeam)

			local VIP = table.Random(Re2_Teams.StarsTeam)
			SetGlobalEntity( "Team01_VIP", VIP  )
			VIP:Give("weapon_physcannon")

			PrintTable(Re2_Teams.UmbrellaTeam)

			local VIP1 = table.Random(Re2_Teams.UmbrellaTeam)
			SetGlobalEntity( "Team02_VIP", VIP1  )
			VIP1:Give("weapon_physcannon")

			timer.Create("Re2_CountDowntimer_Vip",1,0, function()
			SetGlobalInt("Re2_CountDown", GetGlobalInt("Re2_CountDown") - 1)
				if GetGlobalInt("Re2_CountDown") <= 0 then

					GAMEMODE:BaseStart()
					timer.Destroy("Re2_CountDowntimer_Vip")
				end

			end
			)
		end,

		StartFunction = function()
		SetGlobalInt("Re2_CountDown", 300 + (table.Count(team.GetPlayers(TEAM_HUNK)) * 60) )

		---------------------Set the Re2_CountDown
				timer.Create("Re2_CountDown_TEAMVIP",1,0, function()

						SetGlobalInt("RE2_GameTime", GetGlobalInt("RE2_GameTime") + 1)
						SetGlobalInt("Re2_CountDown", GetGlobalInt("Re2_CountDown") - 1)
							for _,ply in pairs(team.GetPlayers(TEAM_HUNK)) do
								ply:SetNWInt("Time",ply:GetNWInt("Time") + 1 )
							end
							if GetGlobalInt("Re2_CountDown") <= 0 then
								timer.Destroy("Re2_CountDown_TEAMVIP")
								GAMEMODE:BaseEndGame()
							end
					end)

		end,

		CheckFunction = function()
					if GetGlobalEntity("Team01_VIP"):Team() != TEAM_HUNK  || GetGlobalEntity("Team02_VIP"):Team() != TEAM_HUNK then
						GAMEMODE:BaseEndGame()
						return
					end
		end,

		EndFunction = function()
				for _,ply in pairs(player.GetAll()) do
					if ply:Team() == TEAM_HUNK then
						ply:SetNWBool("Infected", false)
						ply:SetNWInt("InfectedPercent", 0)

						ply:DeathReward()

					end
				end

				local Starskills = 0
				local Umbrellakills = 0

				if GetGlobalEntity("Team01_VIP"):Team() != TEAM_HUNK && GetGlobalEntity("Team02_VIP"):Team() == TEAM_HUNK then
					SetGlobalString("Re2_TEAMVIP_Winner","Umbrella")
				elseif GetGlobalEntity("Team02_VIP"):Team() != TEAM_HUNK && GetGlobalEntity("Team01_VIP"):Team() == TEAM_HUNK then
					SetGlobalString("Re2_TEAMVIP_Winner","S.T.A.R.S")
				elseif GetGlobalEntity("Team01_VIP"):Team() == TEAM_HUNK && GetGlobalEntity("Team02_VIP"):Team() == TEAM_HUNK && GetGlobalEntity("Team01_VIP"):Health() > GetGlobalEntity("Team02_VIP"):Health() then
					SetGlobalString("Re2_TEAMVIP_Winner","S.T.A.R.S")
				elseif GetGlobalEntity("Team02_VIP"):Team() == TEAM_HUNK && GetGlobalEntity("Team01_VIP"):Team() == TEAM_HUNK && GetGlobalEntity("Team02_VIP"):Health() >= GetGlobalEntity("Team01_VIP"):Health() then
					SetGlobalString("Re2_TEAMVIP_Winner","Umbrella")
				else
					SetGlobalString("Re2_TEAMVIP_Winner","Umbrella")
				end
			timer.Destroy("Re2_CountDowntimer")
		end,

		DifficultyFunction = function()
			if !GetGlobalBool("Re2_Classic") then
				GAMEMODE.ZombieDatafast = GAMEMODE.ZombieDatafast + 1
				//table.insert(GAMEMODE.ZombieData.Zombies,"snpc_zombie_crimzon")
			end
		end,

		RewardFunction = function()

			local reward = math.Round((GetGlobalInt("RE2_DeadZombies") + #player.GetAll() * 60 + 300)  /2)
			reward = reward * GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier * 2
			for _,ply  in pairs(player.GetAll()) do
				if ply:GetNWInt("TeamId") == 1 && GetGlobalString("Re2_TEAMVIP_Winner") == "S.T.A.R.S" then
					ply:SetNWInt("Money",math.Round(ply:GetNWInt("Money")+ reward))
				elseif ply:GetNWInt("TeamId") == 2 && GetGlobalString("Re2_TEAMVIP_Winner") == "Umbrella" then
					ply:SetNWInt("Money",math.Round(ply:GetNWInt("Money")+ reward))
				end
			end
			PrintMessage( HUD_PRINTTALK, "The "..GetGlobalString("Re2_TEAMVIP_Winner").." Team Won! They are awarded $"..reward.." each. Fine Work!" )
		end,

		HudFunction = function(ply)
				if SERVER then return end
				local SW = ScrW()
				local SH = ScrH()
				local client = LocalPlayer()
				if GetGlobalString("Mode") == "Merchant" then return end

				for _,ply in pairs(team.GetPlayers(TEAM_HUNK)) do
					if ply:GetNWInt("TeamId") == 1 && LocalPlayer() != ply && ply:GetPos():Distance(LocalPlayer():GetPos()) <= 400 then
						local pos = ply:LocalToWorld(ply:OBBCenter() + Vector(0,0,40)):ToScreen()
						DrawIcon(surface.GetTextureID("re2_teams/stars"),pos.x,pos.y,48,48 )
					elseif  ply:GetNWInt("TeamId") == 2 && LocalPlayer() != ply && ply:GetPos():Distance(LocalPlayer():GetPos()) <= 400 then
						local pos = ply:LocalToWorld(ply:OBBCenter() + Vector(0,0,40)):ToScreen()
						DrawIcon(surface.GetTextureID("re2_teams/umbrella"),pos.x,pos.y,48,48 )
					end
				end

				if GetGlobalString("Mode") == "End" then
					if GetGlobalString("Re2_TEAMVIP_Winner") == "Umbrella" then
						DrawIcon(surface.GetTextureID("re2_teams/umbrella" ),SW/2 - 150, SH/2 - 150 ,300,300)
						draw.SimpleText("Umbrella Wins","Trebuchet18o",SW/2 ,SH/2 + 150 + 10,Color(255,255,255,255),1,0)
					elseif GetGlobalString("Re2_TEAMVIP_Winner") == "S.T.A.R.S" then
						DrawIcon(surface.GetTextureID("re2_teams/stars" ),SW/2 - 123, SH/2 - 144 ,246,288)
						draw.SimpleText("S.T.A.R.S Wins","Trebuchet18o",SW/2,SH/2 + 144 + 10,Color(255,255,255,255),1,0)
					end
				end

				if ply:GetNWInt("TeamId") == 1 then
					DrawIcon(surface.GetTextureID("re2_teams/stars" ),SW/2 - 16, SH - SH + 28 ,32,32)
					if ply != GetGlobalEntity("Team01_VIP") && GetGlobalEntity("Team01_VIP"):Team() == TEAM_HUNK then
						local Vipcolor = Color(0,155,0,250)
						if GetGlobalEntity("Team01_VIP"):Health() >= 75 then
								Vipcolor = Color(0,155,0,250)
							elseif GetGlobalEntity("Team01_VIP"):Health() >= 51 and GetGlobalEntity("Team01_VIP"):Health() <= 74 then
								Vipcolor = Color(155,155,0,250)
							elseif GetGlobalEntity("Team01_VIP"):Health() >= 20 and GetGlobalEntity("Team01_VIP"):Health() <= 50 then
								Vipcolor = Color(155,100,0,250)
							elseif GetGlobalEntity("Team01_VIP"):Health() <= 19 then
								Vipcolor = Color(155,0,0,250)
							end
						local min,max,cen = GetGlobalEntity("Team01_VIP"):LocalToWorld(GetGlobalEntity("Team01_VIP"):OBBMins()), GetGlobalEntity("Team01_VIP"):LocalToWorld(GetGlobalEntity("Team01_VIP"):OBBMaxs()), GetGlobalEntity("Team01_VIP"):LocalToWorld(GetGlobalEntity("Team01_VIP"):OBBCenter())
						local minl,maxl,cenp = min:Distance(cen), max:Distance(cen), cen:ToScreen()
						local minp = (cen + (ply:GetRight() * (-1 * minl)) + (ply:GetUp() * (-1 * minl))):ToScreen()
						local maxp = (cen + (ply:GetRight() * maxl) + (ply:GetUp() * maxl)):ToScreen()
						if not cenp.visible then
							DrawTime = nil
						return end
						surface.SetDrawColor(Vipcolor)
						surface.DrawLine(minp.x,maxp.y,maxp.x,maxp.y)
						surface.DrawLine(minp.x,maxp.y,minp.x,minp.y)
						surface.DrawLine(minp.x,minp.y,maxp.x,minp.y)
						surface.DrawLine(maxp.x,maxp.y,maxp.x,minp.y)
						surface.SetDrawColor(255,255,255,155)
						surface.SetTextPos(minp.x+2,maxp.y-15)
						local text = "Protect This Player"
						surface.SetFont("DefaultSmall")
						surface.DrawText(text)
						surface.SetDrawColor(255,255,255,255)
						surface.SetTextPos(minp.x+2,maxp.y-15)
						surface.SetFont("Default")
						surface.DrawText(text)
					elseif ply == GetGlobalEntity("Team01_VIP") && GetGlobalEntity("Team01_VIP"):Team() == TEAM_HUNK then
						surface.SetFont("Trebuchet18o")
						local textx,texty = surface.GetTextSize("You are the Vip")
						draw.SimpleText("You are the Vip","Trebuchet18o",SW/2 - textx/2,SH - SH + 60,Color(255,255,255,255),0,0)
					end
				elseif ply:GetNWInt("TeamId") == 2 then
					DrawIcon(surface.GetTextureID("re2_teams/umbrella" ),SW/2 - 16, SH - SH + 28 ,32,32)
					if ply != GetGlobalEntity("Team02_VIP") && GetGlobalEntity("Team02_VIP"):Team() == TEAM_HUNK then
						DrawIcon(surface.GetTextureID("re2_teams/umbrella"),SW/2 - 16, SH - SH + 28 ,32,32)
						local Vipcolor = Color(0,155,0,250)
							if GetGlobalEntity("Team02_VIP"):Health() >= 75 then
								Vipcolor = Color(0,155,0,250)
							elseif GetGlobalEntity("Team02_VIP"):Health() >= 51 and GetGlobalEntity("Team02_VIP"):Health() <= 74 then
								Vipcolor = Color(155,155,0,250)
							elseif GetGlobalEntity("Team02_VIP"):Health() >= 20 and GetGlobalEntity("Team02_VIP"):Health() <= 50 then
								Vipcolor = Color(155,100,0,250)
							elseif GetGlobalEntity("Team02_VIP"):Health() <= 19 then
								Vipcolor = Color(155,0,0,250)
							end
						local min,max,cen = GetGlobalEntity("Team02_VIP"):LocalToWorld(GetGlobalEntity("Team02_VIP"):OBBMins()), GetGlobalEntity("Team02_VIP"):LocalToWorld(GetGlobalEntity("Team02_VIP"):OBBMaxs()), GetGlobalEntity("Team02_VIP"):LocalToWorld(GetGlobalEntity("Team02_VIP"):OBBCenter())
						local minl,maxl,cenp = min:Distance(cen), max:Distance(cen), cen:ToScreen()
						local minp = (cen + (ply:GetRight() * (-1 * minl)) + (ply:GetUp() * (-1 * minl))):ToScreen()
						local maxp = (cen + (ply:GetRight() * maxl) + (ply:GetUp() * maxl)):ToScreen()
						if not cenp.visible then
							DrawTime = nil
						return end
						surface.SetDrawColor(Vipcolor)
						surface.DrawLine(minp.x,maxp.y,maxp.x,maxp.y)
						surface.DrawLine(minp.x,maxp.y,minp.x,minp.y)
						surface.DrawLine(minp.x,minp.y,maxp.x,minp.y)
						surface.DrawLine(maxp.x,maxp.y,maxp.x,minp.y)
						surface.SetDrawColor(255,255,255,155)
						surface.SetTextPos(minp.x+2,maxp.y-15)
						local text = "Protect This Player"
						surface.SetFont("DefaultSmall")
						surface.DrawText(text)
						surface.SetDrawColor(255,255,255,255)
						surface.SetTextPos(minp.x+2,maxp.y-15)
						surface.SetFont("Default")
						surface.DrawText(text)
					elseif ply == GetGlobalEntity("Team02_VIP") && GetGlobalEntity("Team02_VIP"):Team() == TEAM_HUNK then
						surface.SetFont("Trebuchet18o")
						local textx,texty = surface.GetTextSize("You are the Vip")
						draw.SimpleText("You are the Vip","Trebuchet18o",SW/2 - textx/2,SH - SH + 60,Color(255,255,255,255),0,0)
					end
				end
			end,
		}
