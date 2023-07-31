local ITEM = {}

-- NEVER REPEAT CLASS NAMES
ITEM.ClassName = "item_mixedherb2"
ITEM.WeaponClass = false

ITEM.Name = "mixedherb2"
ITEM.Desc = "mixedherb2"
ITEM.Model = "models/resident evil/item_herbgre.mdl"

ITEM.Price = 100
ITEM.Max = 1

ITEM.Category = "Admin"

ITEM.Loot = true
ITEM.LootChance = 0.4

ITEM.Restrictions = false

function ITEM:OnUsed( ply )

	if ply:Health() < ply:GetMaxHealth() or ply:GetNWBool( "Infected", true ) then

		ply:SetHealth( ply:GetMaxHealth() )
		ply:EmitSound("items/smallmedkit1.wav",110,100)
		ply:SetNWBool("Infected", false) 
		ply:SetNWInt("InfectedPercent", 0) 
		ply:PrintTranslatedMessage(HUD_PRINTTALK,"infection_cured") 
		ply:EmitSound("HL1/fvox/antidote_shot.wav",110,100)
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
		return true
	end

	

	
	
	return false

end

function ITEM:OnDropped( ply )

end

item.Register( ITEM )

 