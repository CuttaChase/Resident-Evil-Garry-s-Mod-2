
net.Receive("InvTransfer", function( len ) 
	local decoded = net.ReadTable()
	LocalPlayer().inventory = decoded.Inv 
	LocalPlayer().Upgrades = decoded.Upg
	LocalPlayer().Chest = decoded.Chest
	GAMEMODE.OwnedPerks = decoded.Perks
	LocalPlayer().EquippedPerks = decoded.ActPs
	GAMEMODE.OwnedModels = decoded.PModels
	LocalPlayer().EquippedModel = decoded.ActMdl

	if MENU.Inventory then
		MENU:ReloadInventory()
		return
	end

	if MENU.MainMerchant then
		if MENU.LastMerc == "Storage" then
			MENU:MerchantStorage()
		elseif MENU.LastMerc == "Perks" then
			MENU:MerchantPerks()
		elseif MENU.LastMerc == "Upgrades" then
			MENU:MerchantUpgrades()
		elseif MENU.LastMerc == "Player Models" then
			MENU:MerchantPlayerModel()
		end
	end
	
end )

net.Receive( "REGmod.OpenMerchant", function( len )

	if MENU.Inventory then
		MENU.Inventory:Remove()
		MENU.Inventory = nil
	end
	
	GAMEMODE.InMenu = false
	MENU:MerchantMenu()
	
	
end )

net.Receive( "REGmod.OpenOptions", function( len )

	MENU:OptionsMenu()
	
end )

net.Receive( "REGmod.OpenVoting", function( len )

	MENU:VotingMenu()
	
end )

net.Receive( "REGmod.OpenAdmin", function( len )

	MENU:AdminMenu()
	
end )

net.Receive( "REGmod.OpenSkills", function( len )

	MENU:SkillsMenu()
	
end )

net.Receive( "REGmod.HealthUp", function( len )

	print("THE HEALTH!")

end )

net.Receive( "REGmod.AttackPower", function( len )

	print("THE POWER!")

end )

net.Receive( "REGmod.SendUpgradeData", function( len )

	local upgrades = net.ReadTable()
	local class = net.ReadString( 32 )
	
	LocalPlayer().Upgrades = upgrades
	
	if LocalPlayer():GetActiveWeapon() then
		if LocalPlayer():GetActiveWeapon():GetClass() == class then
			timer.Simple( 0.1, function() LocalPlayer():GetActiveWeapon():Update() end )
		end
	end
	
	if MENU.MainMerchant then
		if MENU.LastMerc == "Upgrades" then
			MENU:MerchantUpgrades()
		end
	end

end )