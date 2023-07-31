AddCSLuaFile()

if SERVER then
	util.AddNetworkString("DR_Experienced")
else
surface.CreateFont( "ExpPoints", {
                        font = "Tahoma",
                        size = 32,
                        weight = 800} )

surface.CreateFont( "ExpPointsB", {
                        font = "Tahoma",
                        size = 24,
                        weight = 500} )
end


hook.Add("PlayerInitialSpawn","InitializerPlayer",function(ply)
	--[[
	ply:SetNWInt("Level",ply:GetPData("Level",1))
	ply:SetNWInt("GamesPlayed",ply:GetPData("GamesPlayed",0)+1)
	ply:SetNWInt("Experience",ply:GetPData("Experience",0))
	ply:SetPData("GamesPlayed",ply:GetNWInt("GamesPlayed",1))

	]]

end)

--[[

hook.Add("EntityTakeDamage","FixDamage",function(ent,dmg)
	if(ent:IsPlayer()) then
		local l = math.floor(ent:GetLevel()/10)
		dmg:ScaleDamage(1-5*l)
	end
end)

]]

----Health Skill
hook.Add("PlayerSpawn","GiveHealth",function(ply)
	--local l = math.floor(ply:GetLevel()/10)
	local l = ply:GetNWInt("HealthPoints")/4
	ply:SetMaxHealth(ply:GetMaxHealth()+l)
	print(""..ply:Nick().." has "..ply:GetMaxHealth().." max health")
end)



----Attack Skill
hook.Add("EntityTakeDamage", "GiveAttack", function(ent, dmg)
	if (IsValid(ent)) then

		local damage = dmg:GetDamage();

		if (damage < 1) then
			return;
		end

		local attacker = dmg:GetAttacker();
		if (not IsValid(attacker) or not attacker:IsPlayer()) then
			return;
		end

		local points = attacker:GetNWInt("AttackPoints")
		if (points <= 0) then
			return; 
		end

		local weapon = attacker:GetActiveWeapon();

		

			local realDamage = damage + (points / 4);
			if (ent:IsPlayer()) && ent:Team() == TEAM_HUNK then
				dmg:SetDamage(realDamage);
			end

		--print(realDamage)
	end
end)


-----Ammo Regen Skill

local AmmoRegenCooldown = 0
hook.Add("Think", "AmmoRegenSkill", function()

	if (CurTime() < AmmoRegenCooldown ) then return end
	local ammoregenpoints
	local players = player.GetAll()
	for i = 1, #players do

			local player = players[i]

			ammoregenpoints = player:GetNWInt("AmmoRegenPoints")

			local weapon = player:GetActiveWeapon()

			


			if (ammoregenpoints > 0) then
				
				local amt = 15


				player:SetAmmo( math.Clamp(player:GetAmmoCount( "pistol" ) + (amt - 2), 0, AmmoMax[ "pistol" ]), "pistol" )
				player:SetAmmo( math.Clamp(player:GetAmmoCount( "smg1" ) + (amt), 0, AmmoMax[ "smg1" ]), "smg1" )
				player:SetAmmo( math.Clamp(player:GetAmmoCount( "ar2" ) + (amt - 4), 0, AmmoMax[ "ar2" ]), "ar2" )
				player:SetAmmo( math.Clamp(player:GetAmmoCount( "357" ) + (amt - 6), 0, AmmoMax[ "357" ]), "357" )
				player:SetAmmo( math.Clamp(player:GetAmmoCount( "buckshot" ) + (amt - 7), 0, AmmoMax[ "buckshot" ]), "buckshot" )

				if SERVER then
					player:EmitSound( "items/ammo_pickup.wav", 110, 100 )
				end
						
			end
	end

	if ammoregenpoints != nil then
		AmmoRegenCooldown = CurTime() + (105 - ammoregenpoints)
	end
end)


local promoted = {}

hook.Add("OnNPCKilled","AddExperience",function(npc,kill)
	if kill:IsPlayer() and ( !kill:IsUserGroup("donator") or !kill:IsUserGroup("donator_moderator") or !kill:IsUserGroup("vip") or !kill:IsUserGroup("superadmin") ) then
		kill:giveExp(10)
	else
		kill:giveExp(20)
	end
end)

local ply = FindMetaTable("Player")

if SERVER then
	util.AddNetworkString("SyncLevel")
	util.AddNetworkString("SyncLevelUp")
end

function ply:giveExp(exp)


	self:SetNWInt("Experience",self:GetNWInt("Experience",0)+tonumber(exp))
	self:SetPData("Experience",self:GetNWInt("Experience",0))

	local nlevel = 50 * (((self:GetNWInt("Level",1)+1)^1.5)) *2

	if(self:GetNWInt("Experience",0) > nlevel) then
		self:SetNWInt("Level",self:GetNWInt("Level",1)+1)
		self:SetPData("Level",self:GetNWInt("Level",1))
		self:LevelUp()
		self:giveExp(0)
	end

	net.Start("DR_Experienced")
	net.WriteFloat(exp)
	net.Send(self)
end

function ply:LevelUp()
	self:SetNWInt("SkillPoints",self:GetNWInt("SkillPoints") + 1)

	if(self:GetLevel()%10 == 0) then
		--self:SetNWInt("SkillPoints",self:GetNWInt("SkillPoints") + 1)
	end

	if(self:GetLevel() == 50) then
	//	self:AddPoints(49000)
	end
end

function ply:GetLevel()
	return tonumber(self:GetNWInt("Level",1))
end

function ply:GetExp(t)
	if(t == nil) then t = 0 end

	if(t == 0) then
		return self:GetNWInt("Experience",0)
	elseif(t == 1) then

		local nlevel = tonumber(50 * (((self:GetNWInt("Level",1)+1)^1.5)))*2
		local blevel = tonumber(50 * (((self:GetNWInt("Level",1))^1.5)))*2
		local a = self:GetNWInt("Experience",0)
		return (a-blevel)/(nlevel-blevel)

	elseif(t == 2) then
		return tonumber(50 * (((self:GetNWInt("Level",1)+1)^1.5)))*2
	end

end

function ply:GamesPlayed()
	return self:GetNWInt("GamesPlayed",1)
end

function ply:GetLevelColor()
	local l = tonumber(self:GetLevel() or 1)
	if(l < 10) then
		return Color(241,241,241)
	elseif(l < 20) then
		return Color(46, 204, 113)
	elseif(l < 30) then
		return Color(52, 152, 219)
	elseif(l < 40) then
		return Color(155, 89, 182)
	elseif(l < 50) then
		return Color(230, 126, 34)
	else
		return Color(241, 196, 15)
	end
end

