local ITEM = {}

-- NEVER REPEAT CLASS NAMES
ITEM.ClassName = "item_m1921"
ITEM.WeaponClass = "m1921"

ITEM.Name = "THOMPSON"
ITEM.Desc = "THOMPSON"
ITEM.Model = "models/weapons/w_smg_ump45.mdl"

ITEM.Price = 25000
ITEM.Max = 1

ITEM.Category = "Weapons"

ITEM.Loot = false
ITEM.LootChance = 0

ITEM.Restrictions = false

ITEM.Upgrades = {}
ITEM.Upgrades[ "power" ] = {

	GetDisp = function( level ) return translate.Format( "upgrade_stat_power", ITEM.Upgrades[ "power" ].GetNew( level ) ) end,
	
	GetCost = function( level ) return ( 500 + level*1200 ) end,
	
	GetNew = function( level ) return ( 8 + 1.4*level ) end,
	
	Apply = function( wep, level )
		wep.Primary.Damage = ITEM.Upgrades[ "power" ].GetNew( level )
	end,

	MaxLevel = 30,
	
}

ITEM.Upgrades[ "precision" ] = {

	GetDisp = function( level ) return translate.Format( "upgrade_stat_precision", ITEM.Upgrades[ "precision" ].GetNew( level ) ) end,
	
	GetCost = function( level ) return ( 100 + level*400 ) end,
	
	GetNew = function( level ) return ( 0.5 - 0.01*level ) end,
	
	Apply = function( wep, level )
		wep.Primary.Spread =  ITEM.Upgrades[ "precision" ].GetNew( level )
	end,
	
	MaxLevel = 30,
	
}

ITEM.Upgrades[ "capacity" ] = {

	GetDisp = function( level ) return translate.Format( "upgrade_stat_capacity", ITEM.Upgrades[ "capacity" ].GetNew( level ) ) end,
	
	GetCost = function( level ) return ( 300 + level*300 ) end,
	
	GetNew = function( level ) return ( 50 + 1*level ) end,
	
	Apply = function( wep, level )
		wep.Primary.ClipSize =  ITEM.Upgrades[ "capacity" ].GetNew( level )
	end,
	
	MaxLevel = 15,
	
}

ITEM.Upgrades[ "chambering" ] = {

	GetDisp = function( level ) return translate.Format( "upgrade_stat_chambering", math.Round( 1/ITEM.Upgrades[ "chambering" ].GetNew( level ) ) ) end,
	
	GetCost = function( level ) return ( 400 + ( level^2 )*100 ) end,
	
	GetNew = function( level ) return ( 0.20 - 0.008*level ) end,
	
	Apply = function( wep, level )
		wep.Primary.ReloadingTime =  ITEM.Upgrades[ "chambering" ].GetNew( level )
	end,
	
	MaxLevel = 20,
	
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

 