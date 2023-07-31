

hook.Add( "ShouldCollide", "CustomCollisions", function( ent1, ent2 )

    -- If players are about to collide with each other, then they won't collide.
	if ent1:IsNextBot() && ent2:IsNextBot() then
		return false
	elseif ent1:IsNPC() && ent2:IsNPC() then
		return false
	elseif ent1:IsPlayer() && (ent2:IsPlayer() && ent2:Team() == TEAM_HUNK) then
		return false
	elseif ent1:IsNextBot() && (ent2:IsPlayer() && ent2:Team() == TEAM_CROWS) then
		return false
	elseif ent1:GetClass() == "Quad_Rocket" && ent2:IsPlayer() then
		return false
	elseif ent1:GetClass() == "m79_bomb" && ent2:IsPlayer() then
		return false
	end

end )

hook.Add("ShowTeam","DisableTeams",function(ent,a)
	
	return false
	
	
end)

function GM:PlayerSetHandsModel( ply, ent )

	local simplemodel = player_manager.TranslateToPlayerModelName( ply:GetModel() )
	local info = player_manager.TranslatePlayerHands( simplemodel )
	if ( info ) then
		ent:SetModel( info.model )
		ent:SetSkin( info.skin )
		ent:SetBodyGroups( info.body )
	end

end

---------------------------Load Next Map Function------------------

function GM:LoadNextMap()
	game.LoadNextMap()
end


---------------------Add Time To Amount Of Players In Server For VIP---------------



local onlyonce = false

hook.Add("PlayerSay","GotStuck",function(ply, text, team)

	if string.sub(text,1,6) == "!stuck" then
	
	
	for _,spawnpoint in pairs(ents.FindByClass("Re2_player_round_start")) do
		if GetGlobalString("Mode") == "On" then
					if !spawnpoint.Taken && onlyonce == false then
						ply:SetPos(spawnpoint:GetPos())
						spawnpoint.Taken = true
						onlyonce = true
						timer.Simple(15, function() onlyonce = false  end)
						break
					end
		end

	end
			
		ply:ChatPrint(translate.ClientGet(ply, "unstuck_only_once"))
		
		
	end

end)

-------------------PVP Hook--------------------------
--[[

hook.Add("PlayerShouldTakeDamage","KillPlayers", function(ply,a)
	
	if (GetGlobalString("RE2_Game") == "PVP") && GetGlobalString( "Mode", "On" ) && ply:IsPlayer() && a:IsPlayer() && ply:Team() == a:Team() then
		return true
	end

end)

--]]

--------Makes sure players cannot pick up nemesis minigun------------------
hook.Add( "PlayerCanPickupWeapon", "NoNPCPickups", function( ply, wep )
	if ( wep.IsNPCWeapon ) then return false end
end )

-----------a zombie spawns in the dead players place when they die--------------------
--hook.Add("PlayerDeath","TurnPlayerZombie",function(ply,a,b)
--	if(a:GetClass() == "snpc_infected_s" || b:GetClass() == "snpc_infected_s") then
--		local ent = ents.Create("snpc_infected_s")
--		ent:SetPos(ply:GetPos())
--		ent:Spawn()
--		NumZombies = NumZombies + 1
--	end
--end)


--Barricades on maps to take damage from zombies---

function cadeEntityTakeDamage( ent, dmginfo )
	if IsValid(ent) then
		if ent.isCade then
			if dmginfo:GetAttacker():GetClass() == "player" then dmginfo:SetDamage(0) end
			if dmginfo:GetAttacker():GetClass() == "env_explosion" && dmginfo:GetAttacker().Owner:IsPlayer() then dmginfo:SetDamage(0) end
			ent:SetHealth(ent:Health() - dmginfo:GetDamage())
			if (dmginfo:GetAttacker():GetClass() == "snpc_zombie_dog") then
				dmginfo:GetAttacker().times = dmginfo:GetAttacker().times/2
			end
			if ent:Health() <= 0 then
				ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
				ent.isCade = false
				if (dmginfo:GetAttacker():GetClass() == "snpc_*") then
						dmginfo:GetAttacker():FindEnemy()
				end
				ent:Remove()
				
			end
		end
	end
end
hook.Add("EntityTakeDamage", "cadeEntityTakeDamage", cadeEntityTakeDamage)


