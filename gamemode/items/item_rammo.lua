local ITEM = {}

-- NEVER REPEAT CLASS NAMES
ITEM.ClassName = "item_rammo"
ITEM.WeaponClass = false

ITEM.Name = "rifleammo"
ITEM.Desc = "rifleammo"
ITEM.Model = "models/items/boxsrounds.mdl"

ITEM.Price = 30
ITEM.Max = 3

ITEM.Category = "Ammunition"

ITEM.Loot = true
ITEM.LootChance = 0.5

ITEM.Restrictions = false


function ITEM:OnUsed( ply )

	local ammotype = "ar2"
	local ammo = ply:GetAmmoCount( ammotype )
	local maxammo = AmmoMax[ ammotype ] 
	local amt = 40
	
	if ammo >= maxammo then return false end

	ply:SetAmmo( math.Clamp( ammo + amt, 0, maxammo ), ammotype )
	
	ply:EmitSound( "items/ammo_pickup.wav", 110, 100 )
	
	return true
	
end

function ITEM:OnDropped( ply )

end

item.Register( ITEM )

 