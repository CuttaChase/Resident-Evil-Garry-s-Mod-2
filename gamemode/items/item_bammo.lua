local ITEM = {}

-- NEVER REPEAT CLASS NAMES
ITEM.ClassName = "item_bammo"
ITEM.WeaponClass = false

ITEM.Name = "buckshotammo"
ITEM.Desc = "buckshotammo"
ITEM.Model = "models/items/boxbuckshot.mdl"

ITEM.Price = 40
ITEM.Max = 3

ITEM.Category = "Ammunition"

ITEM.Loot = true
ITEM.LootChance = 0.5

ITEM.Restrictions = false

function ITEM:OnUsed( ply )

	local ammotype = "buckshot"
	local ammo = ply:GetAmmoCount( ammotype )
	local maxammo = AmmoMax[ ammotype ] 
	local amt = 10
	
	if ammo >= maxammo then return false end

	ply:SetAmmo( math.Clamp( ammo + amt, 0, maxammo ), ammotype )
	
	ply:EmitSound( "items/ammo_pickup.wav", 110, 100 )
	
	return true
	
end

function ITEM:OnDropped( ply )

end

item.Register( ITEM )

 