local ITEM = {}

-- NEVER REPEAT CLASS NAMES
ITEM.ClassName = "item_mixedherb1"
ITEM.WeaponClass = false

ITEM.Name = "Mixed Herb R/G"
ITEM.Desc = "Heals Decent wounds"
ITEM.Model = "models/resident evil/item_herbgre.mdl"

ITEM.Price = 100
ITEM.Max = 2

ITEM.Category = "Admin"

ITEM.Loot = true
ITEM.LootChance = 0.4

ITEM.Restrictions = false

function ITEM:OnUsed( ply )

	if ply:Health() < ply:GetMaxHealth() then
		ply:SetHealth( ply:Health() + 50 )
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
	
	return false

end

function ITEM:OnDropped( ply )

end

ITEM.CustomOptions = {


	[ "Combine" ] = function( ply )


			local inv = ply.inventory
			local mixedherb = "item_mixedherb2"
			local redherb = "item_rherb"
			local greenherb = "item_gherb"
			local blueherb = "item_bherb"
			local number = 1

			
			for k,v in pairs( inv ) do
				if v.Item == blueherb then
					if v.Amount == 1 && INVENTORY:HasRoom( ply, inv, 1 ) then
						INVENTORY:Add( ply, mixedherb, number )
						v.Item = 0
						return true
					elseif v.Amount == 2 && INVENTORY:HasRoom( ply, inv, 1 ) then							v.Item = redherb
						v.Amount = 1
						INVENTORY:Add( ply, mixedherb, number )
						return true
					elseif v.Amount == 3 && INVENTORY:HasRoom( ply, inv, 1 ) then
						v.Item = redherb
						v.Amount = 2
						INVENTORY:Add( ply, mixedherb, number )
						return true
					end
				end
			end



			if not ply:Alive() then return end
			
			


			
			
	end,

}

item.Register( ITEM )

 