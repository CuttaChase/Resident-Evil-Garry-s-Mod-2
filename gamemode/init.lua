DeadPlayers = {}

AddCSLuaFile("config.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include( "config.lua" )
include( "translate.lua" )


AddCSLuaFile("cl/cl_hud.lua")
AddCSLuaFile("cl/cl_scoreboard.lua")
AddCSLuaFile("cl/cl_net.lua")
AddCSLuaFile("cl/cl_music.lua")


AddCSLuaFile( "vgui/vgui_framework.lua" )
AddCSLuaFile( "vgui/vgui_options.lua" )
AddCSLuaFile( "vgui/vgui_inventory.lua" )
AddCSLuaFile( "vgui/vgui_merchantmenu.lua" )
AddCSLuaFile( "vgui/vgui_votemenu.lua" )
AddCSLuaFile( "vgui/vgui_adminmenu.lua" )
AddCSLuaFile( "vgui/vgui_skills.lua" )
AddCSLuaFile( "vgui/vgui_hud.lua" )


AddCSLuaFile("modules/upgrades.lua")
include("modules/upgrades.lua")
include("modules/chests.lua")
include("modules/perk_module.lua")
include("modules/inventory.lua")
include("modules/music.lua")
include("modules/models_module.lua")


include( "sv/voting.lua" )
include( "sv/hooks.lua" )
include( "sv/sv_net.lua" )
include( "sv/player.lua" )
include( "sv/sh_ply_extension.lua" )
include( "sv/gamemodes.lua" )
include( "sv/admincommands.lua" )


-- DataStreams
if SERVER then
	util.AddNetworkString("InvTransfer")
	util.AddNetworkString("VoteTransfer")
end

function SendDataToAClient(ply)
	GAMEMODE:InvTransfer(ply)

end

concommand.Add("InvUpdate",
	function(ply,command,args)
	SendDataToAClient(ply)
	end)

function GM:InvTransfer( ply )
	ply = ply or player.GetAll()
	net.Start("InvTransfer")
		net.WriteTable( {Inv = ply.inventory, Upg = ply.Upgrades, Chest = ply.Chest, Perks = ply.OwnedPerks, ActPs = ply.EquippedPerks, PModels = ply.OwnedModels, ActMdl = ply.EquippedModel} )
	net.Send(ply)
end


DiffLevel = 1
game.ConsoleCommand("mapcyclefile Regmod.txt\n")
game.ConsoleCommand("mp_falldamage 1\n")
local PREPARED = false

function GM:Initialize()
	SetGlobalString( "Mode", "Merchant" )
	isInRound = false
	timer.Simple(5, function() GAMEMODE:UpdateMap() end)
	GAMEMODE.TEMP_DeadPlayers = {}
	NumZombies = 0
	VotingDifficulty = {}
	VotingMaps = {}
	VotingGamemodes = {}
	for k,v in pairs(GamemodeListTable) do
		VotingGamemodes[tostring(v)] = 0
	end
	for k,v in pairs(MapListTable) do
		VotingMaps[v] = 0
	end
	for k,v in pairs(EscapeListTable) do
		VotingMaps[v] = 0
	end
	for k,v in pairs(BossListTable) do
		VotingMaps[v] = 0
	end
	for k,v in pairs(GAMEMODE.ZombieData) do
		VotingDifficulty[k] = 0
	end

	GAMEMODE:BasePrep()

	timer.Create( "GameChecker", 100, 0, function()
				if GetGlobalString("Mode") != "End" then
					GAMEMODE:GameCheck()
				end
	end )



end

function GM:AddToTime(ply)
	if ply:Team() == TEAM_HUNK then
		if ply:Alive() then
			ply:SetNWInt("Time", ply:GetNWInt("Time") + 1)
		end
	end
end


--SavingAndLoading

function Save(ply)
	local str_Steam = string.Replace(ply:SteamID(),":",";")
	local path_FilePath = "re2/"..str_Steam..".txt"

	local Savetable = {}
	Savetable["Money"] = ply:GetMoney()
	Savetable["Inventory"] = ply.inventory
	Savetable["Upgrades"] = ply.Upgrades
	Savetable["Chest"] = ply.Chest

	local ownprks = {}
	for prk, _ in pairs( ply.OwnedPerks ) do
		table.insert( ownprks, prk )
	end

	local ownmdls = {}
	for mdl, _ in pairs( ply.OwnedModels ) do
		table.insert( ownmdls, mdl )
	end

	Savetable["OwnedPerks"] = ownprks
	Savetable["EquippedPerks"] = ply.EquippedPerks
	Savetable["Invslots"] = ply:GetMaxInventory()
	Savetable["Chestslots"] = ply:GetMaxStorage()
	Savetable["OwnedModels"] = ownmdls
	Savetable["EquippedModel"] = ply.EquippedModel
	Savetable["EquippedModelPath"] = ply.EquippedModelPath
	Savetable["AttackSkillPoints"] = ply.AttackSkillPoints
	Savetable["HealthSkillPoints"] = ply.HealthSkillPoints

	local StrindedItems = util.TableToKeyValues(Savetable)

	file.Write(path_FilePath,StrindedItems)


end
equippedmodel = 0
equippedmodelpath = ""
mdls2 = {}

mdls2["kleiner"] = "models/player/Kleiner.mdl"
mdls2["mossman"] = "models/player/mossman.mdl"
mdls2["alyx"] = "models/player/alyx.mdl"
mdls2["barney"] = "models/player/barney.mdl"
mdls2["breen"] = "models/player/breen.mdl"
mdls2["monk"] = "models/player/monk.mdl"
mdls2["odessa"] = "models/player/odessa.mdl"
mdls2["combine"] = "models/player/combine_soldier.mdl"
mdls2["prison"] = "models/player/combine_soldier_prisonguard.mdl"
mdls2["super"] = "models/player/combine_super_soldier.mdl"
mdls2["police"] = "models/player/police.mdl"
mdls2["gman"] = "models/player/gman_high.mdl"

mdls2["female1"] = "models/player/Group01/female_01.mdl"
mdls2["female2"] = "models/player/Group01/female_02.mdl"
mdls2["female3"] = "models/player/Group01/female_03.mdl"
mdls2["female4"] = "models/player/Group01/female_04.mdl"
mdls2["female5"] = "models/player/Group01/female_06.mdl"
mdls2["female7"] = "models/player/Group03/female_01.mdl"
mdls2["female8"] = "models/player/Group03/female_02.mdl"
mdls2["female9"] = "models/player/Group03/female_03.mdl"
mdls2["female10"] = "models/player/Group03/female_04.mdl"
mdls2["female11"] = "models/player/Group03/female_06.mdl"

mdls2["male1"] = "models/player/Group01/male_01.mdl"
mdls2["male2"] = "models/player/Group01/male_02.mdl"
mdls2["male3"] = "models/player/Group01/male_03.mdl"
mdls2["male4"] = "models/player/Group01/male_04.mdl"
mdls2["male5"] = "models/player/Group01/male_05.mdl"
mdls2["male6"] = "models/player/Group01/male_06.mdl"
mdls2["male7"] = "models/player/Group01/male_07.mdl"
mdls2["male8"] = "models/player/Group01/male_08.mdl"
mdls2["male9"] = "models/player/Group01/male_09.mdl"

mdls2["male10"] = "models/player/Group03/male_01.mdl"
mdls2["male11"] = "models/player/Group03/male_02.mdl"
mdls2["male12"] = "models/player/Group03/male_03.mdl"
mdls2["male13"] = "models/player/Group03/male_04.mdl"
mdls2["male14"] = "models/player/Group03/male_05.mdl"
mdls2["male15"] = "models/player/Group03/male_06.mdl"
mdls2["male16"] = "models/player/Group03/male_07.mdl"
mdls2["male17"] = "models/player/Group03/male_08.mdl"
mdls2["male18"] = "models/player/Group03/male_09.mdl"
function Load( ply )
	local str_Steam = string.Replace(ply:SteamID(),":",";")
	local path_FilePath = "re2/"..str_Steam..".txt"

		if not file.Exists( path_FilePath, "DATA" ) then
			ply:SetNWInt( "Money", GAMEMODE.Config.StartingMoney )
			ply.inventory = { {Item = 0, Amount = 0}, {Item = 0, Amount = 0}, {Item = 0, Amount = 0}, {Item = 0, Amount = 0}, {Item = 0, Amount = 0}, {Item = 0, Amount = 0} }
			ply:SetMaxInventory( 6 )
			INVENTORY:Add( ply, "item_colt" )
			ply.Chest = {}
			ply.OwnedPerks = {}
			ply.EquippedPerks = { 0, 0, 0 }
			ply.Upgrades = {}
			ply.OwnedModels = {}
			ply.EquippedModel = 0
			ply.EquippedModelPath = ""
			ply.AttackSkillPoints = 0
			ply.HealthSkillPoints = 0
			UPGRADES:InitializeData( ply )
		else
			local data = util.KeyValuesToTable( file.Read( path_FilePath, "DATA" ) )
			local inv = data.inventory
			local upg = data.upgrades
			local money = data.money
			local perks = data.ownedperks
			local chestie = data.chest
			local equippedperks = data.equippedperks
			local invslots = data.invslots
			local chestslots = data.chestslots
			local models = data.ownedmodels
			local equippedmodel = data.equippedmodel
			equippedmodelpath = data.equippedmodelpath
			ply.EquippedModelPath = data.equippedmodelpath
			local attackpoints = data.attackskillpoints
			local healthpoints = data.healthskillpoints


			ply:SetMoney( money )
			ply:SetMaxInventory( invslots )
			ply:SetMaxStorage( chestslots )

			ply.OwnedModels = {}
			if models then
				for _, model in pairs( models ) do
					ply.OwnedModels[ model ] = true
				end
			end
			
			ply.EquippedModel = {}
				if equippedmodel then
					if equippedmodel != 0 then
						MODELS:EquipModel( ply, damodels.GetData( equippedmodel ) )
					else
						ply:SetModel(table.Random(mdls2))
					end
				end

			ply.OwnedPerks = {}

			if perks then
				for _, perk in pairs( perks ) do
					ply.OwnedPerks[ perk ] = true
				end
			end

			ply.EquippedPerks = { 0, 0, 0 }
			for i=1, 3 do
				if equippedperks[ i ] != 0 then
					PERKS:EquipPerk( ply, perky.GetData( equippedperks[ i ] ), i )
				end
			end

			ply.inventory = {}
			for i=1, ply:GetMaxInventory() do
				INVENTORY:ResetSlot( ply, i )
			end
			for k,v in pairs(inv) do
				if v.item != 0 then
					INVENTORY:Add( ply, v.item, v.amount )
				end
			end

			ply.Upgrades = {}
			if upg then
				for gun, data in pairs( upg ) do
					ply.Upgrades[ gun ] = data
				end
			end

			ply.Chest = {}
			if chestie then
				for slot, dat in pairs( chestie ) do
					if dat.Item != 0 then
						ply.Chest[ slot ] = {}
						ply.Chest[ slot ].Item = dat.item
						ply.Chest[ slot ].Amount = dat.amount
					end
				end
			end

			ply.AttackSkillPoints = attackpoints
			ply.HealthSkillPoints = healthpoints

			UPGRADES:InitializeData( ply )
		end
		ply.HasLoaded = true
		SendDataToAClient( ply )

end

function GM:DoInfection(ply)
	if ply:GetNWBool("Infected") && ply:Alive() && ply:GetNWInt("InfectedPercent") < 100 then
		local add = math.random(1,5)
		ply:SetNWInt("InfectedPercent",ply:GetNWInt("InfectedPercent") + add)
		timer.Simple(10,function() GAMEMODE:DoInfection(ply) end)
		if ply:GetNWInt("InfectedPercent") >= 100 then
			ply:Kill()
		end
	end
end

function GM:ScaleNPCDamage(npc,hitgroup,dmginfo)
   if hitgroup == 1 then
		dmginfo:ScaleDamage(2)
   elseif hitgroup == 2 then
		dmginfo:ScaleDamage(1.5)
	elseif hitgroup == 3 then
			dmginfo:ScaleDamage(0.9)
   end
end


-----------------------Items Spawns In Crates On Map

function GM:UpdateMap()
	for k,v in pairs(ents.FindByClass("item_*")) do
		if v:GetClass() ==  "item_item_crate" then
			local itembase = ents.Create("reward_crate")
			itembase:Spawn()
			itembase:SetPos(v:GetPos())
			local keyvaluetable = v:GetKeyValues()
			if keyvaluetable.ItemCount != 0 then
				itembase.Amount = keyvaluetable.ItemCount
			else
				itembase.Amount = math.random(1,4)
			end
			print(keyvaluetable.ItemClass)
			if keyvaluetable.ItemClass == "item_pammo" then
				keyvaluetable.ItemClass = "item_pammo"
			elseif keyvaluetable.ItemClass == "item_mammo" then
				keyvaluetable.ItemClass = "item_pammo"
			elseif keyvaluetable.ItemClass == "item_bammo" then
				keyvaluetable.ItemClass = "item_pammo"
			elseif keyvaluetable.ItemClass == "item_rammo" then
				keyvaluetable.ItemClass = "item_pammo"
			end
			itembase.Item = tostring(keyvaluetable.ItemClass)
			v:Remove()
		end
	end
end
