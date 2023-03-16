local ITEM = {}

-- NEVER REPEAT CLASS NAMES
ITEM.ClassName = "item_pammo"
ITEM.WeaponClass = false

ITEM.Name = "Pistol Ammo"
ITEM.Desc = "30 rounds"
ITEM.Model = "models/re_magazine.mdl"

ITEM.Price = 10
ITEM.Max = 3

ITEM.Category = "Ammunition"

ITEM.Loot = true
ITEM.LootChance = 0.5

ITEM.Restrictions = false

function ITEM:OnUsed( ply )

	local ammotype = "pistol"
	local ammo = ply:GetAmmoCount( ammotype )
	local maxammo = AmmoMax[ ammotype ] 
	local amt = 30
	
	if ammo >= maxammo then return false end

	ply:SetAmmo( math.Clamp( ammo + amt, 0, maxammo ), ammotype )
	
	ply:EmitSound( "items/ammo_pickup.wav", 110, 100 )
	
	return true
	
end

function ITEM:OnDropped( ply )

end

item.Register( ITEM )

 