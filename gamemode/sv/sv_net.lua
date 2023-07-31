
util.AddNetworkString( "REGmod.UseItem" )
util.AddNetworkString( "REGmod.GiveItem" )
util.AddNetworkString( "REGmod.CustomItemOption" )
util.AddNetworkString( "REGmod.DropItem" )
util.AddNetworkString( "REGmod.BuyItem" )
util.AddNetworkString( "REGmod.SellItem" )
util.AddNetworkString( "REGmod.StoreItem" )
util.AddNetworkString( "REGmod.EquipItem" )
util.AddNetworkString( "REGmod.PurchaseInventorySlot" )
util.AddNetworkString( "REGmod.PurchaseStorageSlot" )
util.AddNetworkString( "REGmod.BuyPerk" )
util.AddNetworkString( "REGmod.EquipPerk" )
util.AddNetworkString( "REGmod.UnequipPerk" )
util.AddNetworkString( "REGmod.OpenMerchant" )
util.AddNetworkString( "REGmod.OpenOptions" )
util.AddNetworkString( "REGmod.OpenVoting" )
util.AddNetworkString( "REGmod.OpenSkills" )
util.AddNetworkString( "REGmod.OpenAdmin" )
util.AddNetworkString( "REGmod.BuyUpgrade" )
util.AddNetworkString( "REGmod.SendUpgradeData" )
util.AddNetworkString( "REGmod.BuyModel" )
util.AddNetworkString( "REGmod.EquipModel" )
util.AddNetworkString( "REGmod.UnequipModel" )
util.AddNetworkString( "REGmod.HealthUp" )
util.AddNetworkString( "REGmod.AttackPower" )
util.AddNetworkString( "REGmod.OpenLeaderboards" )
util.AddNetworkString( "REGmod.AmmoRegen" )


---------------------------------------------------------------------------------MENUS

net.Receive( "REGmod.OpenMerchant", function( len, ply )

	if GetGlobalString("Mode") != "Merchant" and ply:Team() == TEAM_HUNK then return end

	net.Start( "REGmod.OpenMerchant" )
	net.Send( ply )

end )

net.Receive( "REGmod.OpenAdmin", function( len, ply )

	if !ply:IsSuperadmin() or !ply:IsAdmin() then return end

	net.Start( "REGmod.OpenAdmin" )
	net.Send( ply )

end )

net.Receive( "REGmod.OpenVoting", function( len, ply )

	if GetGlobalString("Mode") == "End" then return end

	net.Start( "REGmod.OpenVoting" )
	net.Send( ply )

end )

net.Receive( "REGmod.OpenSkills", function( len, ply )

	net.Start( "REGmod.OpenSkills" )
	net.Send( ply )

end )

---------------------------------------------------------------------------------ITEMS

net.Receive( "REGmod.UseItem", function( len, ply )

	local class = net.ReadString( 32 )
	local slot = net.ReadInt( 32 )

	if not ply:Alive() then return end

	if ply.inventory[ slot ].Item != class then
		SendDataToAClient( ply )
		return
	end

	local itemtbl = item.GetItem( class )
	if not itemtbl then return end

	if ply.inventory[ slot ].Amount < 1 then
		INVENTORY:ResetSlot( ply, slot )
		return
	end

	if itemtbl.Restrictions then
		if not itemtbl.Restrictions[ ply:GetUserGroup() ] then return end
	end
	if ply:Team() == TEAM_HUNK then
	INVENTORY:Use( ply, itemtbl, slot )
	end
end )

net.Receive( "REGmod.DropItem", function( len, ply )

	local class = net.ReadString( 32 )
	local slot = net.ReadInt( 32 )

	if not ply:Alive() then return end

	if ply.inventory[ slot ].Item != class then
		SendDataToAClient( ply )
		return
	end

	local itemtbl = item.GetItem( class )
	if not itemtbl then return end

	if ply.inventory[ slot ].Amount < 1 then
		INVENTORY:ResetSlot( ply, slot )
		return
	end
	if ply:Team() == TEAM_HUNK then
	INVENTORY:Drop( ply, itemtbl, slot )
	end
end )

net.Receive( "REGmod.GiveItem", function( len, ply )

	local class = net.ReadString( 32 )
	local slot = net.ReadInt( 32 )

	if not ply:Alive() then return end

	if ply.inventory[ slot ].Item != class then
		SendDataToAClient( ply )
		return
	end

	local itemtbl = item.GetItem( class )
	if not itemtbl then return end

	if ply.inventory[ slot ].Amount < 1 then
		INVENTORY:ResetSlot( ply, slot )
		return
	end
	if ply:Team() == TEAM_HUNK then
	INVENTORY:Give( ply, itemtbl, slot )
	end
end )

net.Receive( "REGmod.CustomItemOption", function( len, ply )

	local class = net.ReadString( 32 )
	local func = net.ReadString( 32 )
	local slot = net.ReadInt( 32 )

	if not ply:Alive() then return end

	if ply.inventory[ slot ].Item != class then
		SendDataToAClient( ply )
		return
	end

	local itemtbl = item.GetItem( class )
	if not itemtbl then return end

	if ply.inventory[ slot ].Amount < 1 then
		INVENTORY:ResetSlot( ply, slot )
		return
	end

	if itemtbl.Restrictions then
		if not itemtbl.Restrictions[ ply:GetUserGroup() ] then return end
	end

	if not itemtbl.CustomOptions[ func ] then return end
	if ply:Team() == TEAM_HUNK then
	INVENTORY:CustomOption( ply, itemtbl, slot, func )
	end
end )

-------------------------------------------------------------------MERCHANT / STORAGE

net.Receive( "REGmod.BuyItem", function( len, ply )

	local class = net.ReadString( 32 )

	local itemtbl = item.GetItem( class )
	if not itemtbl then return end

	if ply:GetMoney() < itemtbl.Price then return end

	if table.Count( ply.Chest ) >= ply:GetMaxStorage() then return end

	CHEST:BuyItem( ply, itemtbl )

end )

net.Receive( "REGmod.SellItem", function( len, ply )

	local isinventory = net.ReadBool()
	local slot = net.ReadInt( 32 )

	if isinventory then
		if not ply.inventory[ slot ] then return end
		if ply.inventory[ slot ].Item == 0 then return end
		if ply.inventory[ slot ].Amount < 1 then
			INVENTORY:ResetSlot( ply, slot )
			SendDataToAClient( ply )
		return
		end
	else
		if not ply.Chest[ slot ] then return end
		if ply.Chest[ slot ].Item == 0 then return end
		if ply.Chest[ slot ].Amount < 1 then
			ply.Chest[ slot ] = nil
			SendDataToAClient( ply )
			return
		end
	end

	CHEST:SellItem( ply, slot, isinventory )

end )

net.Receive( "REGmod.StoreItem", function( len, ply )

	local slot = net.ReadInt( 32 )
	if not ply.inventory[ slot ] then return end

	local class = ply.inventory[ slot ].Item
	if class == 0 then return end

	local amt = ply.inventory[ slot ].Amount
	if amt < 1 then
		INVENTORY:ResetSlot( ply, slot )
		SendDataToAClient( ply )
		return
	end

	local itemtbl = item.GetItem( class )
	if not itemtbl then return end

	if table.Count( ply.Chest ) >= ply:GetMaxStorage() then return end

	CHEST:Deposit( ply, itemtbl, slot )

end )

net.Receive( "REGmod.EquipItem", function( len, ply )

	local slot = net.ReadInt( 32 )

	if not ply.Chest[ slot ] then return end

	if ply.Chest[ slot ].Amount < 1 then
		ply.Chest[ slot ] = nil
		SendDataToAClient( ply )
		return
	end

	local class = ply.Chest[ slot ].Item

	local itemtbl = item.GetItem( class )
	if not itemtbl then return end

	CHEST:EquipItem( ply, itemtbl, slot )

end )

net.Receive( "REGmod.PurchaseInventorySlot", function( len, ply )

	if ply:GetMoney() < GAMEMODE.Config.InventorySlotPrice then
		return
	end

	if ply:GetMaxInventory() >= 10 then
		return
	end

	ply:AddInventorySlot()
	ply:AddMoney( -1*GAMEMODE.Config.InventorySlotPrice )
	SendDataToAClient( ply )
end )



net.Receive( "REGmod.PurchaseStorageSlot", function( len, ply )

	if ply:GetMoney() < GAMEMODE.Config.StorageSlotPrice then
		return
	end

	if ply:GetMaxStorage() >= GAMEMODE.Config.MaxStorageSlots then
		return
	end

	ply:AddStorageSlot()
	ply:AddMoney( -1*GAMEMODE.Config.StorageSlotPrice )
	SendDataToAClient( ply )
end )


----------------------------------------------------------------------------------PERKS

net.Receive( "REGmod.BuyPerk", function( len, ply )

	local class = net.ReadString( 32 )

	local itemtbl = perky.GetData( class )
	if not itemtbl then return end

	if ply:GetMoney() < itemtbl.Price then return end

	if ply.OwnedPerks[ class ] then return end

	PERKS:BuyPerk( ply, itemtbl )

end )

net.Receive( "REGmod.EquipPerk", function( len, ply )

	local slot = net.ReadInt( 32 )
	local class = net.ReadString( 32 )

	if ply.EquippedPerks[ slot ] == class then return end

	local itemtbl = perky.GetData( class )
	if not itemtbl then return end
	if ply:Team() == TEAM_HUNK then
	PERKS:EquipPerk( ply, itemtbl, slot )
	end
end )

net.Receive( "REGmod.UnequipPerk", function( len, ply )

	local class = net.ReadString( 32 )

	local itemtbl = perky.GetData( class )
	if not itemtbl then return end
	if ply:Team() == TEAM_HUNK then
	PERKS:RemovePerk( ply, itemtbl )
	end
end )

net.Receive( "REGmod.BuyUpgrade", function( len, ply )

	local class = net.ReadString( 32 )
	local upg = net.ReadString( 32 )

	local itemtbl = item.GetItem( class )
	if not itemtbl then return end

	if not itemtbl.Upgrades then return end
	if not itemtbl.Upgrades[ upg ] then return end

	local pupg = ply.Upgrades[ class ]
	if not pupg then
		UPGRADES:InitializeWeapon( ply, class, true )
		return
	end

	local level = pupg[ upg ] or 0
	if itemtbl.Upgrades[ upg ].MaxLevel then
		if itemtbl.Upgrades[ upg ].MaxLevel <= level then return end
	end

	local cost = itemtbl.Upgrades[ upg ].GetCost( level )
	if ply:GetMoney() < cost then return end

	UPGRADES:SetUpgrade( ply, class, upg, level + 1 )
	ply:AddMoney( -1*cost )

	class = itemtbl.WeaponClass

	net.Start( "REGmod.SendUpgradeData" )
		net.WriteTable( ply.Upgrades )
		net.WriteString( class, 32 )
	net.Send( ply )

	if ply:GetActiveWeapon() then
		if ply:GetActiveWeapon():IsValid() then
			if ply:GetActiveWeapon():GetClass() == class then
				timer.Simple( 0.1, function() ply:GetActiveWeapon():Update() end )
			end
		end
	end

end )




-------------------------------------------------------------------------------------------------MODELS

net.Receive( "REGmod.BuyModel", function( len, ply )

	local class = net.ReadString( 32 )

	local itemtbl = damodels.GetData( class )
	if not itemtbl then return end

	if ply:GetMoney() < itemtbl.Price then return end

	if ply.OwnedModels[ class ] then return end

	MODELS:BuyModel( ply, itemtbl )
	Save(ply)

end )

net.Receive( "REGmod.EquipModel", function( len, ply )





	local class = net.ReadString( 32 )

		if ply.EquippedModel == class then return end
		--print("yayyyyyyy")
		thismodelon = true
		local itemtbl = damodels.GetData( class )
		if not itemtbl then return end
		if ply:Team() == TEAM_HUNK then
		MODELS:EquipModel( ply, itemtbl, slot )
		end



end )

net.Receive( "REGmod.UnequipModel", function( len, ply )



	local class = net.ReadString( 32 )

		thismodelon = false
		local itemtbl = damodels.GetData( class )
		if not itemtbl then return end
		if ply:Team() == TEAM_HUNK then
		MODELS:RemoveModel( ply, itemtbl )
		end



end )


----------------------------------------skills

net.Receive( "REGmod.HealthUp", function( len, ply )
	
	if ply:GetNWInt("SkillPoints") > 0 then
		ply:PrintMessage(HUD_PRINTCENTER,"Health Up!")
		ply:SetNWInt("HealthPoints", ply:GetNWInt("HealthPoints") + 1)
		ply:SetNWInt("SkillPoints", ply:GetNWInt("SkillPoints") - 1)
		ply:PrintMessage(HUD_PRINTCENTER,"You Have ".. ply:GetNWInt("SkillPoints") .. " Skill Points Left")
	else
		ply:PrintMessage(HUD_PRINTCENTER,"You Don't Have Enough Skill Points")
	end

end )



net.Receive( "REGmod.AttackPower", function( len, ply )

	if ply:GetNWInt("SkillPoints") > 0 then
		ply:PrintMessage(HUD_PRINTCENTER,"Power Up!")
		ply:SetNWInt("AttackPoints", ply:GetNWInt("AttackPoints") + 1)
		ply:SetNWInt("SkillPoints", ply:GetNWInt("SkillPoints") - 1)
		ply:PrintMessage(HUD_PRINTCENTER,"You Have ".. ply:GetNWInt("SkillPoints") .. " Skill Points Left")
	else
		ply:PrintMessage(HUD_PRINTCENTER,"You Don't Have Enough Skill Points")
	end

end )

net.Receive( "REGmod.AmmoRegen", function( len, ply )

	if ply:GetNWInt("SkillPoints") > 0 then
		ply:PrintMessage(HUD_PRINTCENTER,"Ammo Regen Up!")
		ply:SetNWInt("AmmoRegenPoints", ply:GetNWInt("AmmoRegenPoints") + 1)
		ply:SetNWInt("SkillPoints", ply:GetNWInt("SkillPoints") - 1)
		ply:PrintMessage(HUD_PRINTCENTER,"You Have ".. ply:GetNWInt("SkillPoints") .. " Skill Points Left")
	else
		ply:PrintMessage(HUD_PRINTCENTER,"You Don't Have Enough Skill Points")
	end

end )