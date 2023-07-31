local ITEM = {}

-- NEVER REPEAT CLASS NAMES
ITEM.ClassName = "item_tcure"
ITEM.WeaponClass = false

ITEM.Name = "tcure"
ITEM.Desc = "tcure"
ITEM.Model = "models/props/re2_remake_orion_gun_antibody_shell.mdl"

ITEM.Price = 500
ITEM.Max = 1

ITEM.Category = "Supplies"

ITEM.Loot = true
ITEM.LootChance = 0.2

ITEM.Restrictions = false

function ITEM:OnUsed( ply )

	if not ply:GetNWBool( "Infected", false ) then
		ply:PrintTranslatedMessage(HUD_PRINTTALK,"you_are_not_infected") 
		return false
	end

	ply:SetNWBool("Infected", false) 
	ply:SetNWInt("InfectedPercent", 0) 
	ply:PrintTranslatedMessage(HUD_PRINTTALK,"infection_cured") 
	ply:EmitSound("HL1/fvox/antidote_shot.wav",110,100)
	
	return true
	
end

function ITEM:OnDropped( ply )

end

item.Register( ITEM )

 