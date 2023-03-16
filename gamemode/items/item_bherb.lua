local ITEM = {}

-- NEVER REPEAT CLASS NAMES
ITEM.ClassName = "item_bherb"
ITEM.WeaponClass = false

ITEM.Name = "Blue Herb"
ITEM.Desc = "Its A Weird Thing"
ITEM.Model = "models/resident evil/item_herbblu.mdl"

ITEM.Price = 100
ITEM.Max = 3

ITEM.Category = "Supplies"

ITEM.Loot = true
ITEM.LootChance = 0.4

ITEM.Restrictions = false

function ITEM:OnUsed( ply )

	if ply:Health() < ply:GetMaxHealth() then
		ply:SetHealth( ply:Health() + 5 )
		ply:EmitSound("items/smallmedkit1.wav",110,100)
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
	if not ply:GetNWBool( "Infected", false ) then
		ply:PrintMessage(HUD_PRINTTALK,"You are not infected!") 
		return false
	end

			ply:SetNWInt("InfectedPercent", ply:GetNWInt("InfectedPercent") - 5)
			ply:PrintTranslatedMessage(HUD_PRINTTALK, "infection_lowered")
			ply:EmitSound("items/smallmedkit1.wav",110,100)
	return true

end

function ITEM:OnDropped( ply )

end

item.Register( ITEM )

 