
UPGRADES = {}

function UPGRADES:GetUpgrades( ply, wep )
	if ply:IsValid() then
		return ply.Upgrades[ wep ]
	else
		return true
	end
end

function UPGRADES:SetUpgrade( ply, wep, name, level )
	if CLIENT then return end
	if not ply.Upgrades[ wep ] then
		ply.Upgrades[ wep ] = {}
	end
	
	ply.Upgrades[ wep ][ name ] = level
end

function UPGRADES:InitializeWeapon( ply, class, immediate )
	if CLIENT then return end
	
	local itm = item.GetItem( class )
	if not itm then return end
	if not itm.Upgrades then return end

	for att, data in pairs( itm.Upgrades ) do
		if not ply.Upgrades[ class ] then
			ply.Upgrades[ class ] = {}
		end
		if ply.Upgrades[ class ][ att ] then continue end
		UPGRADES:SetUpgrade( ply, class, att, 0 )
	end	

	if immediate then
		net.Start( "REGmod.SendUpgradeData" )
			net.WriteTable( ply.Upgrades )
			net.WriteString( class, 32 )
		net.Send( ply )
	end
	
end

function UPGRADES:InitializeData( ply )
	
	local weplist = self:GetWeapons( ply )
	
	for class, _ in pairs( weplist ) do
		if not ply.Upgrades[ class ] then
			self:InitializeWeapon( ply, class )
		end
	end
	
end

function UPGRADES:GetWeapons( ply )

	local weplist = {}
	
	for slot, data in pairs( ply.Chest ) do
		if not ply.Chest[ slot ] then continue end
		if item.IsValidWeapon( data.Item ) then
			weplist[ data.Item ] = true
		end
	end
	
	for slot, data in pairs( ply.inventory ) do
		if item.IsValidWeapon( data.Item ) then
			weplist[ data.Item ] = true
		end	
	end
	
	return weplist

end