local ITEM = {}

-- NEVER REPEAT CLASS NAMES
ITEM.ClassName = "item_3ammo"
ITEM.WeaponClass = false

ITEM.Name = "magnumammo"
ITEM.Desc = "magnumammo"
ITEM.Model = "models/items/357ammobox.mdl"

ITEM.Price = 50
ITEM.Max = 3

ITEM.Category = "Ammunition"

ITEM.Loot = true
ITEM.LootChance = 0.5

ITEM.Restrictions = false


function ITEM:OnUsed( ply )

	local ammotype = "357"
	local ammo = ply:GetAmmoCount( ammotype )
	local maxammo = AmmoMax[ ammotype ] 
	local amt = 12
	
	if ammo >= maxammo then return false end

	ply:SetAmmo( math.Clamp( ammo + amt, 0, maxammo ), ammotype )
	
	ply:EmitSound( "items/ammo_pickup.wav", 110, 100 )
	
	return true
	
end

function ITEM:OnDropped( ply )

end

item.Register( ITEM )

 