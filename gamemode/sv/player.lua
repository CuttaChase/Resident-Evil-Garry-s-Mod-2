game.AddAmmoType( {
	name = "357",
	dmgtype = DMG_BULLET,
	tracer = TRACER_LINE,
	plydmg = 50,
	npcdmg = 50,
	maxcarry = 36,
	force = 2000,
	minsplash = 20,
	maxsplash = 10
} )

---------------------------------------------Player BUtton Setups-----------
function GM:ShowSpare2( ply )
	--ply:ConCommand( "Re2_VoteMenu" )
	net.Start( "REGmod.OpenVoting" )
	net.Send( ply )
end

function GM:ShowTeam( ply )
end

hook.Add( "PlayerButtonDown", "SkillsKey", function( ply, key )
	if ply:IsAdmin() then
		if ( key == KEY_F7 )  then
			net.Start( "REGmod.OpenSkills" )
			net.Send( ply )
		end
	end
end )

-----------------------------------------------------
hook.Add( "PlayerButtonDown", "AdminKey", function( ply, key )
	if ( key == KEY_F6 ) && (ply:IsAdmin() or ply:IsSuperAdmin() )  then
		net.Start( "REGmod.OpenAdmin" )
		net.Send( ply )
	end
end )
-------------------------------------------------------

function GM:ShowHelp( ply )
	net.Start( "REGmod.OpenOptions" )
	net.Send( ply )
end
----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------
---------------------------------------------Default Models-----------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------
local mdls = {}

mdls["kleiner"] = "models/player/Kleiner.mdl"
mdls["mossman"] = "models/player/mossman.mdl"
mdls["alyx"] = "models/player/alyx.mdl"
mdls["barney"] = "models/player/barney.mdl"
mdls["breen"] = "models/player/breen.mdl"
mdls["monk"] = "models/player/monk.mdl"
mdls["odessa"] = "models/player/odessa.mdl"
mdls["combine"] = "models/player/combine_soldier.mdl"
mdls["prison"] = "models/player/combine_soldier_prisonguard.mdl"
mdls["super"] = "models/player/combine_super_soldier.mdl"
mdls["police"] = "models/player/police.mdl"
mdls["gman"] = "models/player/gman_high.mdl"

mdls["female1"] = "models/player/Group01/female_01.mdl"
mdls["female2"] = "models/player/Group01/female_02.mdl"
mdls["female3"] = "models/player/Group01/female_03.mdl"
mdls["female4"] = "models/player/Group01/female_04.mdl"
mdls["female5"] = "models/player/Group01/female_06.mdl"
mdls["female7"] = "models/player/Group03/female_01.mdl"
mdls["female8"] = "models/player/Group03/female_02.mdl"
mdls["female9"] = "models/player/Group03/female_03.mdl"
mdls["female10"] = "models/player/Group03/female_04.mdl"
mdls["female11"] = "models/player/Group03/female_06.mdl"

mdls["male1"] = "models/player/Group01/male_01.mdl"
mdls["male2"] = "models/player/Group01/male_02.mdl"
mdls["male3"] = "models/player/Group01/male_03.mdl"
mdls["male4"] = "models/player/Group01/male_04.mdl"
mdls["male5"] = "models/player/Group01/male_05.mdl"
mdls["male6"] = "models/player/Group01/male_06.mdl"
mdls["male7"] = "models/player/Group01/male_07.mdl"
mdls["male8"] = "models/player/Group01/male_08.mdl"
mdls["male9"] = "models/player/Group01/male_09.mdl"

mdls["male10"] = "models/player/Group03/male_01.mdl"
mdls["male11"] = "models/player/Group03/male_02.mdl"
mdls["male12"] = "models/player/Group03/male_03.mdl"
mdls["male13"] = "models/player/Group03/male_04.mdl"
mdls["male14"] = "models/player/Group03/male_05.mdl"
mdls["male15"] = "models/player/Group03/male_06.mdl"
mdls["male16"] = "models/player/Group03/male_07.mdl"
mdls["male17"] = "models/player/Group03/male_08.mdl"
mdls["male18"] = "models/player/Group03/male_09.mdl"

function GM:PlayerInitialSpawn(ply)
	ply.CanEarn = true
	if GAMEMODE.TEMP_DeadPlayers[ply:UniqueID()] || GAMEMODE.TEMP_DeadPlayers[ply:UniqueID()] == nil then
		ply:SetTeam(TEAM_HUNK)
	elseif !GAMEMODE.TEMP_DeadPlayers[ply:UniqueID()] or !ply:Team(TEAM_BUNK) or !ply:Team(TEAM_FUNK) then
		ply:SetTeam(TEAM_CROWS)
		ply:Spectate( OBS_MODE_ROAMING )
	end
	ply:SetNWInt("Speed",160)
	ply:SetNWInt("Speed2",160)
	ply.EquippedPerks = { 0, 0, 0 }
	ply.HasBeenAlive = false
	ply:SetViewEntity(ply)
	
	Load( ply )

	timer.Simple(10,function()
		if GetGlobalString("Mode") != "Merchant" && ents.FindByClass("Re2_player_round_start") != nil then
			local randomspawnpoint = table.Random(ents.FindByClass("Re2_player_round_start"))
			ply:SetPos(randomspawnpoint:GetPos())
		end
	end)

	if GAMEMODE.Gamemode[GetGlobalString("Re2_Game")] != nil then
		if GAMEMODE.Gamemode[GetGlobalString("Re2_Game")].JoinFunction != nil then
			GAMEMODE.Gamemode[GetGlobalString("Re2_Game")].JoinFunction(ply)
		end
	end
	
end




function GM:PlayerSpawn(ply)
	ply:SetupHands()
	if ply:Team() == TEAM_HUNK || ply:Team() == TEAM_FUNK then
		ply:SetNWBool("Infected", false)
		ply:SetNWInt("InfectedPercent", 0)
		if equippedmodel != 0 then
			print(equippedmodel)
			ply:SetModel(equippedmodel)
		else
			ply:SetModel(table.Random(mdls))
		end

		GAMEMODE:PlayerLoadout(ply)
		ply:SetNWInt("killcount",0)
		ply:SetNWInt("Time",0)
		ply:SetNWInt("MaxHP", 100)
		ply:SetNWInt("Immunity", 50)
		ply:AllowFlashlight(true)
	else
		ply:AllowFlashlight(true)
		ply:BecomeCrow()
		ply:SetNoCollideWithTeammates( true )
	end
	if ply:Team() != TEAM_CROWS then
		if ply.EquippedModel == "adawong" then
			timer.Simple(3, function() ply:EmitSound("re2_voicelines/adawong_v/ada_namesada.mp3",110,100) end)
		else
			ply:EmitSound("residentevil/residentevilfx_re.mp3",110,100)
		end
	end

	GAMEMODE:SetPlayerSpeed(ply,ply:GetNWInt("Speed"),ply:GetNWInt("Speed2"))
	ply.CanUse = true
	SendDataToAClient(ply)

end

local PLY = FindMetaTable("Player")

function PLY:BecomeCrow()
		self:UnSpectate()

		if self.CrowEnt != nil then
			self.CrowEnt:SetPos(self:GetPos() )
			self.CrowEnt:SetAngles(self:GetAngles())
		else
			self.CrowEnt = ents.Create("prop_dynamic")
			self.CrowEnt:SetModel("models/error.mdl")
			self.CrowEnt:Spawn()
			self.CrowEnt:SetAngles(self:GetAngles())
			self.CrowEnt:SetMoveType(MOVETYPE_NONE)
			self.CrowEnt:SetParent(self)
			self.CrowEnt:SetPos(self:GetPos() )
			self.CrowEnt:SetRenderMode(RENDERMODE_NONE)
			self.CrowEnt:SetSolid(SOLID_NONE)
			self.CrowEnt:SetNoDraw(true)
			self:SetViewEntity(self.CrowEnt)
		end
		self:AddFlags( FL_NOTARGET )
		self:SetNoCollideWithTeammates( true )
		self:SetModel("models/crow.mdl")
		self:SetHull( Vector(-8,-8,0) ,Vector(0,8,10))
		self:SetHullDuck( Vector(-8,-8,0) ,Vector(8,8,10))
		self:SetViewOffset(Vector(2,2,5))
		self:SetViewOffsetDucked(Vector(2,2,5))
		self:SetAllowFullRotation(true)
		self:SetMoveType(MOVETYPE_FLY)
		self:SetCollisionGroup( COLLISION_GROUP_WORLD )
		self:GetObserverMode( OBS_MODE_ROAMING )
		self:Give("re2_crow")
		self:SelectWeapon("re2_crow")
		self:SetHealth(20)
		GAMEMODE:SetPlayerSpeed(self,self:GetNWInt("Speed")*3,self:GetNWInt("Speed2")*3)

end

function GM:DoPlayerDeath(ply,attacker,dmginfo)
	ply:CreateRagdoll()

	ply:SetTeam(TEAM_CROWS)

	ply:Freeze(false)
	Save(ply)
	ply.NextSpawnTime = CurTime() + 30
	ply.DeathTime = CurTime()
	if ply:Team() == TEAM_CROWS then
		SetGlobalInt("RE2_DeadZombies", GetGlobalInt("RE2_DeadZombies") + 1)
	end

	GAMEMODE:GameCheck()

end

function GM:PlayerDeathThink( ply )

	if (  ply.NextSpawnTime && ply.NextSpawnTime > CurTime() ) then return end

	if ( ply:KeyPressed( IN_ATTACK ) || ply:KeyPressed( IN_ATTACK2 ) || ply:KeyPressed( IN_JUMP ) ) then
		ply:SetNWBool("Infected", false)
		ply:SetNWInt("InfectedPercent", 0)
		local money = (ply:GetNWInt("Time")/60)*(ply:GetNWInt("killcount")/3)
		if ply.CanEarn then
				ply:SetNWInt("Money",math.Round(ply:GetNWInt("Money")+(ply:GetNWInt("Time")/60)*(ply:GetNWInt("killcount")/3)))
				ply.CanEarn = false
		end
		ply:SetTeam(TEAM_CROWS)
		ply:Spawn()
	end
end

function GM:PlayerLoadout(ply)
	ply:GiveAmmo( AmmoMax["smg1"], "SMG1", true )
	ply:GiveAmmo( AmmoMax["buckshot"], "buckshot", true )
	ply:GiveAmmo( AmmoMax["ar2"], "ar2", true )
	ply:GiveAmmo( AmmoMax["pistol"], "pistol", true )
	ply:GiveAmmo( AmmoMax["357"], "357", true )
	ply:GiveAmmo( AmmoMax["StriderMinigun"], "StriderMinigun", true )
	ply:GiveAmmo( AmmoMax["CombineCannon"], "CombineCannon", true )
	ply:GiveAmmo( AmmoMax["GaussEnergy"], "GaussEnergy", true )
	ply:GiveAmmo( AmmoMax["Battery"], "Battery", true )
	ply:GiveAmmo( AmmoMax["RPG_Round"], "RPG_Round", true )
	ply:GiveAmmo( AmmoMax["XBowBolt"], "XBowBolt", true )
	for k,v in pairs( ply.inventory ) do
		local data = item.GetItem( v.Item )
		if not data then continue end
		if data.WeaponClass then
			ply:Give( data.WeaponClass )
		end
	end
	ply:Give("re2_detonator")
	ply:Give("re2_knife")
	ply:SelectWeapon("re2_knife")
end


function GM:PlayerShouldTakeDamage(victim,attacker)
	if victim == attacker then return true end
		if attacker:IsPlayer() && victim:IsPlayer() && attacker:Team() == victim:Team() then
			return false
		end

	if attacker:GetClass() == "env_explosion" && attacker.Owner != nil then
		if attacker.Suicidal && attacker.Owner != victim then
			return false
		elseif attacker.Suicidal && attacker.Owner == victim then
			return true
		elseif attacker.Owner == victim || (attacker.Owner:IsPlayer() && attacker.Owner:Team() == victim:Team())  then
			return false
		else
			return true
		end
	end
	return true
end

function GM:PlayerHurt(ply,attacker)

	if ply:Team() == TEAM_HUNK then
		if ply:Health() >= 51 and ply:Health() <= 74 then
			GAMEMODE:SetPlayerSpeed(ply,140,140)
		elseif ply:Health() >= 75 then
			GAMEMODE:SetPlayerSpeed(ply,160,160)
		elseif ply:Health() >= 20 and ply:Health() <= 50 then
			GAMEMODE:SetPlayerSpeed(ply,120,120)
		elseif ply:Health() <= 19 then
			GAMEMODE:SetPlayerSpeed(ply,100,100)
		end
	end
	if attacker:GetClass() == "snpc_shambler" or attacker:GetClass() == "snpc_zombie_dog" or attacker:GetClass() == "snpc_shambler2" or attacker:GetClass() == "snpc_zombie_dog2" then
		local ResistChance = math.random(1,100)

		if ResistChance <= ply:GetNWInt("Immunity") and !ply:HasPerk( "perk_immunity" ) then
			if !ply:GetNWBool("Infected") then
				ply:EmitSound("HL1/fvox/biohazard_detected.wav",110,100)
				ply:SetNWBool("Infected",true)

				GAMEMODE:DoInfection(ply)
			end
		elseif ply:GetNWBool("Infected") == false then
			--ply:PrintMessage(HUD_PRINTTALK,"resisted infection")
		end
	elseif attacker:IsPlayer() && attacker:Team() == ply:Team() then
		return false
	end

end

function GM:PlayerUse( ply, ent )
	if !ply.CanUse then return end
	--if ply.CanUse > CurTime() then return end
	if ply:Team() != TEAM_HUNK then return false end

	if ent:GetClass() == "item_c4" || ent:GetClass() == "item_landmine" then
		if ent.Owner != ply && ent.Armed then
			return
		end
	end
		local pos = ply:GetShootPos()
		local ang = ply:GetAimVector()
		local tracedata = {}
		tracedata.start = pos
		tracedata.endpos = pos+(ang*80)
		tracedata.filter = ply
		local trace = util.TraceLine(tracedata)
		if trace.HitNonWorld && trace.Entity.validitem then
		   ent = trace.Entity
		end
	local validitem = item.GetItem( ent:GetClass() )
	if validitem && INVENTORY:HasRoom( ply, validitem, amt ) then
		if validitem.WeaponClass then
			if ent.hasupgrade then
				ply.Upgrades[ent:GetClass()] = ent.Upgrades
			end
		end
		ply:EmitSound("items/itempickup.wav",110,100)
		ply.CanUse = false
		timer.Simple(0.3, function() ply.CanUse = true end)
		INVENTORY:Add( ply, ent:GetClass(), 1 )
		ent:Remove()
	end
	return true
end

function GM:EntityTakeDamage( ent, dmginfo )

	if ( ent:IsPlayer() and dmginfo:IsExplosionDamage() ) then

		dmginfo:ScaleDamage( 0.1 )

	end


end

function GM:PlayerDisconnected( ply )
	Save(ply)
	DeadPlayers[ply:UniqueID()] = false
	if GetGlobalString("Mode") == "On" then
		if GetGlobalString("Game") == "VIP" then
			if GetGlobalEntity("Thevip") == ply then
				EndGame()
				return
			end
		end
	end
	GAMEMODE:GameCheck()
	if GetGlobalString("Mode") == "On" then
		GAMEMODE.TEMP_DeadPlayers[ply:UniqueID()] = false
	end
	if GAMEMODE.Gamemode[GetGlobalString("RE2_Game")].DisconnectFunction != nil then
		GAMEMODE.Gamemode[GetGlobalString("RE2_Game")].DisconnectFunction(ply)
	end
end









--------------------------------------------------

concommand.Add( "regmod_dash", function( ply )
	if not ply.DashDown then ply.DashDown = 0 end
	if ply.DashDown > CurTime() then return end
	if not ply.CanDash then return end

	ply:ViewPunch( Angle(5, 0, 0) )
	ply:SetLocalVelocity( ply:GetForward() * 1300 )
	ply:EmitSound( "npc/headcrab_poison/ph_jump" .. math.random( 1, 3 ) .. ".wav" )
	ply.DashDown = CurTime() + 5
end )










local meta = FindMetaTable("Player")

function meta:SetMoney( amt )
	self:SetNWInt( "Money", math.max( 0, amt ) )
end

function meta:AddMoney( amt )
	if self:HasPerk( "perk_beginner" ) then
		if amt > 0 then
			amt = math.Round( amt*0.25 )
		end
	end
	self:SetNWInt( "Money", ( self:GetMoney() + amt ) )
end


function meta:SetMaxStorage( amt )
	self:SetNWInt( "MaxStorage", math.min( amt, GAMEMODE.Config.MaxStorageSlots ) )
end

function meta:AddStorageSlot()
	self:SetMaxStorage( self:GetMaxStorage() + 1 )
end

function meta:SetMaxInventory( amt )
	self:SetNWInt( "MaxInventory", math.Clamp( amt, 6, 10 ) )
end

function meta:AddInventorySlot()
	self:SetMaxInventory( self:GetMaxInventory() + 1 )
	INVENTORY:ResetSlot( self, math.Clamp( #self.inventory + 1, 6, 10 ) )
end

local PLY = FindMetaTable("Player")

function PLY:DeathReward()
	if self.CanEarn then
		local reward = math.Round((self:GetNWInt("Time")/60) * self:GetNWInt("killcount") / 2 )
		self:SetNWInt("Money",math.Round(self:GetNWInt("Money") + reward ))
		self.CanEarn = false
		self:PrintTranslatedMessage(HUD_PRINTTALK, "you_earned", reward)
	end
end

function HoveringNames2()

	surface.SetTextColor(200,25,25,100)
	surface.SetFont("Trebuchet18")
	local ply = LocalPlayer()
	for _, target in pairs(player.GetAll()) do
		if target:Alive() && target:Team() == TEAM_HUNK then

			local name = target:Nick()
			local targetPos = target:GetPos() + Vector(0,0,64)
			local targetDistance = math.floor((ply:GetPos():Distance( targetPos ))/40)
			local targetScreenpos = targetPos:ToScreen()


			surface.SetTextPos(tonumber(targetScreenpos.x), tonumber(targetScreenpos.y))
			surface.DrawText("Player: "..target:Nick())

		end
	end
end
hook.Add("HUDPaint", "HoveringNames2", HoveringNames2)
