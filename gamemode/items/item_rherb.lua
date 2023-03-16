local ITEM = {}

-- NEVER REPEAT CLASS NAMES
ITEM.ClassName = "item_rherb"
ITEM.WeaponClass = false
ITEM.Herb = "rherb"
ITEM.Name = "Red Herb"
ITEM.Desc = "Can Help With Infection"
ITEM.Model = "models/resident evil/item_herbred.mdl"

ITEM.Price = 100
ITEM.Max = 3

ITEM.Category = "Supplies"

ITEM.Loot = true
ITEM.LootChance = 0.4

ITEM.Restrictions = false

function ITEM:OnUsed( ply )

	--if ply:Health() < ply:GetMaxHealth() then
	--	ply:SetHealth( ply:Health() + 20 )
	--	ply:EmitSound("items/smallmedkit1.wav",110,100)
	--	return true
	--end
	if not ply:GetNWBool( "Infected", false ) then
		ply:PrintMessage(HUD_PRINTTALK,"You are not infected!") 
		return false
	end

			ply:SetNWInt("InfectedPercent", ply:GetNWInt("InfectedPercent") - 15)
			ply:PrintTranslatedMessage(HUD_PRINTTALK, "infection_lowered")
			ply:EmitSound("items/smallmedkit1.wav",110,100)
	return true

end

function ITEM:OnDropped( ply )

end

item.Register( ITEM )

 