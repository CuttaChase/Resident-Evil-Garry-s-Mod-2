local meta = FindMetaTable("Player")

function meta:GetMoney()
	return self:GetNWInt( "Money", 500 )
end

function meta:GetMaxStorage()
	return self:GetNWInt( "MaxStorage", GAMEMODE.Config.InitialStorageSlots )
end


function meta:GetMaxInventory()
	return self:GetNWInt( "MaxInventory", 6 )
end	

function meta:HasPerk( perk ) 

	for i=1, 2 do
		if self.EquippedPerks[ i ] == perk then return true end
	end
	
	return false
	
end

function GM:Move( ply, mv )

		if ply:Team() != TEAM_HUNK && ply:GetMoveType() != MOVETYPE_WALK && ply:OnGround() then
			ply:SetMoveType(MOVETYPE_WALK)
			if SERVER then
				ply:SetAllowFullRotation(false)
				GAMEMODE:SetPlayerSpeed(ply,ply:GetNWInt("Speed"),ply:GetNWInt("Speed2"))
			end
		elseif ply:Team() != TEAM_HUNK && ply:GetMoveType() != MOVETYPE_FLY && !ply:OnGround() then
			ply:SetMoveType(MOVETYPE_FLY)
			if SERVER then
				ply:SetAllowFullRotation(true)
				GAMEMODE:SetPlayerSpeed(ply,ply:GetNWInt("Speed")*3,ply:GetNWInt("Speed2")*3)
			end
		end
		if ply:GetMoveType() == MOVETYPE_FLY && ply:Team() != TEAM_HUNK && ply:GetMoveType() != MOVETYPE_WALK then
			ply:SetVelocity(Vector(ply:GetVelocity().x * -0.1,ply:GetVelocity().y * -0.1, ply:GetVelocity().z * -0.1))
		end

end