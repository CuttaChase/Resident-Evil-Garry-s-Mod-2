local ITEM = {}

-- NEVER REPEAT CLASS NAMES
ITEM.ClassName = "item_tcure"
ITEM.WeaponClass = false

ITEM.Name = "Virus Cure"
ITEM.Desc = "Cures any infection"
ITEM.Model = "models/items/healthkit.mdl"

ITEM.Price = 500
ITEM.Max = 1

ITEM.Category = "Supplies"

ITEM.Loot = true
ITEM.LootChance = 0.2

ITEM.Restrictions = false

function ITEM:OnUsed( ply )

	if not ply:GetNWBool( "Infected", false ) then
		ply:PrintMessage(HUD_PRINTTALK,"You are not infected!") 
		return false
	end

	ply:SetNWBool("Infected", false) 
	ply:SetNWInt("InfectedPercent", 0) 
	ply:PrintMessage(HUD_PRINTTALK,"Infection Cured") 
	ply:EmitSound("HL1/fvox/antidote_shot.wav",110,100)
	
	return true
	
end

function ITEM:OnDropped( ply )

end

item.Register( ITEM )

 