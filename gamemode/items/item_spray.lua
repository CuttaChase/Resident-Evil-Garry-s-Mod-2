local ITEM = {}

-- NEVER REPEAT CLASS NAMES
ITEM.ClassName = "item_spray"
ITEM.WeaponClass = false

ITEM.Name = "spray"
ITEM.Desc = "spray"
ITEM.Model = "models/props/re2_remake_first_aid_spray.mdl"

ITEM.Price = 300
ITEM.Max = 2

ITEM.Category = "Supplies"

ITEM.Loot = true
ITEM.LootChance = 0.4

ITEM.Restrictions = false

function ITEM:OnUsed( ply )

	if ply:Health() < ply:GetMaxHealth() then
		ply:SetHealth( ply:GetMaxHealth() )
		ply:EmitSound("items/smallmedkit1.wav",110,100)
		if ply:Team() == TEAM_HUNK then
			if ply:Health() >= 51 and ply:Health() <= 74 then
				GAMEMODE:SetPlayerSpeed(ply,140,140)
			elseif ply:Health() >= 75 then
				if !ply:HasPerk("perk_training") then
					GAMEMODE:SetPlayerSpeed(ply,160,160)
				else
					GAMEMODE:SetPlayerSpeed(ply,200,200)
				end
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

 