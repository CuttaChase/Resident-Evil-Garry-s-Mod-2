local ITEM = {}

-- NEVER REPEAT CLASS NAMES
ITEM.ClassName = "item_bauto5"
ITEM.WeaponClass = "bauto5"

ITEM.Name = "Browning Auto-5"
ITEM.Desc = "Uses Shotgun Ammo"
ITEM.Model = "models/weapons/w_shot_xm1014.mdl"

ITEM.Price = 50000
ITEM.Max = 1

ITEM.Category = "Weapons"

ITEM.Loot = false
ITEM.LootChance = 0

ITEM.Restrictions = {

	["superadmin"] = true,
	["donor"] = true,

}

ITEM.Upgrades = {}
ITEM.Upgrades[ "power" ] = {

	GetDisp = function( level ) return ITEM.Upgrades[ "power" ].GetNew( level ) .. " DAMAGE" end,
	
	GetCost = function( level ) return ( 800 + level*1000 ) end,
	
	GetNew = function( level ) return ( 11 + 1.5*level ) end,
	
	Apply = function( wep, level )
		wep.Primary.Damage = ITEM.Upgrades[ "power" ].GetNew( level )
	end,

	MaxLevel = 30,
	
}

ITEM.Upgrades[ "precision" ] = {

	GetDisp = function( level ) return ITEM.Upgrades[ "precision" ].GetNew( level ) .. "m SPREAD" end,
	
	GetCost = function( level ) return ( 300 + level*500 ) end,
	
	GetNew = function( level ) return ( 2 - 0.01*level ) end,
	
	Apply = function( wep, level )
		wep.Primary.Spread =  ITEM.Upgrades[ "precision" ].GetNew( level )
	end,
	
	MaxLevel = 5,
	
}

ITEM.Upgrades[ "capacity" ] = {

	GetDisp = function( level ) return ITEM.Upgrades[ "capacity" ].GetNew( level ) .. " ROUNDS PER MAG" end,
	
	GetCost = function( level ) return ( 300 + level*500 ) end,
	
	GetNew = function( level ) return ( 5 + 1*level ) end,
	
	Apply = function( wep, level )
		wep.Primary.ClipSize =  ITEM.Upgrades[ "capacity" ].GetNew( level )
	end,
	
	MaxLevel = 5,
	
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

 