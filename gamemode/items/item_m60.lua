local ITEM = {}

-- NEVER REPEAT CLASS NAMES
ITEM.ClassName = "item_m60"
ITEM.WeaponClass = "m60"

ITEM.Name = "M60"
ITEM.Desc = "Uses Rifle Ammo"
ITEM.Model = "models/weapons/w_irifle.mdl"

ITEM.Price = 105000
ITEM.Max = 1

ITEM.Category = "Weapons"

ITEM.Loot = false
ITEM.LootChance = 0

ITEM.Restrictions = false

ITEM.Upgrades = {}
ITEM.Upgrades[ "power" ] = {

	GetDisp = function( level ) return ITEM.Upgrades[ "power" ].GetNew( level ) .. " DAMAGE" end,
	
	GetCost = function( level ) return ( 2000 + level*3000 ) end,
	
	GetNew = function( level ) return ( 20 + 1.8*level ) end,
	
	Apply = function( wep, level )
		wep.Primary.Damage = ITEM.Upgrades[ "power" ].GetNew( level )
	end,

	MaxLevel = 30,
	
}

ITEM.Upgrades[ "precision" ] = {

	GetDisp = function( level ) return ITEM.Upgrades[ "precision" ].GetNew( level ) .. "m SPREAD" end,
	
	GetCost = function( level ) return ( 100 + level*1000 ) end,
	
	GetNew = function( level ) return ( 0.6 - 0.01*level ) end,
	
	Apply = function( wep, level )
		wep.Primary.Spread =  ITEM.Upgrades[ "precision" ].GetNew( level )
	end,
	
	MaxLevel = 5,
	
}

ITEM.Upgrades[ "capacity" ] = {

	GetDisp = function( level ) return ITEM.Upgrades[ "capacity" ].GetNew( level ) .. " ROUNDS PER MAG" end,
	
	GetCost = function( level ) return ( 1000 + level*1000 ) end,
	
	GetNew = function( level ) return ( 100 + 10*level ) end,
	
	Apply = function( wep, level )
		wep.Primary.ClipSize =  ITEM.Upgrades[ "capacity" ].GetNew( level )
	end,
	
	MaxLevel = 15,
	
}

ITEM.Upgrades[ "chambering" ] = {

	GetDisp = function( level ) return math.Round( 1/ITEM.Upgrades[ "chambering" ].GetNew( level ) ) .. " SHOTS PER SECOND" end,
	
	GetCost = function( level ) return ( 4000 + ( level^2 )*400 ) end,
	
	GetNew = function( level ) return ( 0.20 - 0.01*level ) end,
	
	Apply = function( wep, level )
		wep.Primary.ReloadingTime =  ITEM.Upgrades[ "chambering" ].GetNew( level )
	end,
	
	MaxLevel = 10,
	
}

function ITEM:OnDeploy( ply, wep )

	local upg = UPGRADES:GetUpgrades( ply, self.ClassName )
	
	if not upg then
		if self.DroppedUpgrades then
			for att, level in pairs( self.DroppedUpgrades ) do
				UPGRADES:SetUpgrade( ply, self.ClassName, att, level )
			end
			self.DroppedUpgrades = nil
		else
			UPGRADES:InitializeWeapon( ply, self.ClassName, true )
		end
		upg = UPGRADES:GetUpgrades( ply, self.ClassName )
	end
	
	for name, _ in pairs( self.Upgrades ) do
		if not upg[ name ] then
			UPGRADES:InitializeWeapon( ply, self.ClassName, true )
		end
		upg = UPGRADES:GetUpgrades( ply, self.ClassName )
	end
	
	for name, level in pairs( upg ) do
		if not self.Upgrades[ name ] then continue end
		self.Upgrades[ name ].Apply( wep, level )
	end
	
end

function ITEM:OnUsed( ply )

	if not ply:HasWeapon( self.WeaponClass ) then
		ply:Give( self.WeaponClass )
	end

	ply:SelectWeapon( self.WeaponClass )
	
	return false
	
end

function ITEM:OnDropped( ply )

	ply:StripWeapon( self.WeaponClass )

end

item.Register( ITEM )

 