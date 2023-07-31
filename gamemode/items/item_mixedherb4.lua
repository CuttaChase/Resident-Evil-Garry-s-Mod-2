local ITEM = {}

-- NEVER REPEAT CLASS NAMES
ITEM.ClassName = "item_mixedherb4"
ITEM.WeaponClass = false

ITEM.Name = "mixedherb4"
ITEM.Desc = "mixedherb4"
ITEM.Model = "models/props/re2_remake_herbs.mdl"

ITEM.Price = 100
ITEM.Max = 1

ITEM.Category = "Admin"

ITEM.Loot = true
ITEM.LootChance = 0.4

ITEM.Restrictions = false

function ITEM:OnUsed( ply )

	if ply:Health() < ply:GetMaxHealth() then
		ply:SetHealth( ply:Health() + 150 )
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

 