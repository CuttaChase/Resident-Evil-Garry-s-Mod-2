
CHEST = {}

function CHEST:BuyItem( ply, itemtbl )

	local hasroom, where = self:HasRoom( ply, itemtbl )
	if not hasroom then return end
	
	if where then
		ply.Chest[ where ] = { Item = itemtbl.ClassName, Amount = itemtbl.Max }
	else
		ply.Chest[ #ply.Chest + 1 ] = { Item = itemtbl.ClassName, Amount = itemtbl.Max }
	end
	
	ply:AddMoney( -1*itemtbl.Price )
	ply:EmitSound( table.Random( GAMEMODE.Config.MerchantBuy ), 75, 100 )
	
	if itemtbl.Upgrades then
		UPGRADES:InitializeWeapon( ply, itemtbl.ClassName, true )
	end
	
	SendDataToAClient(ply)
end

function CHEST:SellItem( ply, slot, isinventory )

	if isinventory then	
		local class = ply.inventory[ slot ].Item 
		local amt = ply.inventory[ slot ].Amount
		local itemtbl = item.GetItem( class )
		local cashback = itemtbl.Price*amt*GAMEMODE.Config.SalePercent
		ply:AddMoney( cashback )
		INVENTORY:ResetSlot( ply, slot )
	else
		local class = ply.Chest[ slot ].Item 
		local amt = ply.Chest[ slot ].Amount
		local itemtbl = item.GetItem( class )
		local cashback = itemtbl.Price*amt*GAMEMODE.Config.SalePercent
		ply:AddMoney( cashback )
		ply.Chest[ slot ] = nil	
	end
	SendDataToAClient(ply)
end

function CHEST:Deposit( ply, itemtbl, slot )

	local hasroom, where = self:HasRoom( ply, itemtbl ) 

	if not hasroom then return end

	local class = itemtbl.ClassName
	local amt = ply.inventory[ slot ].Amount
	
	if where then
		ply.Chest[ where ] = { Item = class, Amount = ply.inventory[ slot ].Amount }
	else
		ply.Chest[ #ply.Chest + 1 ] = { Item = class, Amount = ply.inventory[ slot ].Amount }
	end
	if itemtbl.OnDropped then
		itemtbl:OnDropped( ply )
	end
	INVENTORY:ResetSlot( ply, slot )
	SendDataToAClient(ply)
end

function CHEST:EquipItem( ply, itemtbl, slot )

	local class = itemtbl.ClassName
	local amt = ply.Chest[ slot ].Amount
	
	-- put it twice to double check the network!
	
	for i=1, amt do
		if ply.Chest[ slot ].Amount < 1 then ply.Chest[ slot ] = nil SendDataToAClient(ply) break end
		if INVENTORY:HasRoom( ply, itemtbl ) then
			INVENTORY:Add( ply, class )
			ply.Chest[ slot ].Amount = ply.Chest[ slot ].Amount - 1
			SendDataToAClient(ply)
		end
		if ply.Chest[ slot ].Amount < 1 then ply.Chest[ slot ] = nil SendDataToAClient(ply) break end
	end
	
end

function CHEST:HasRoom( ply, itemtbl, amt )

	local name = itemtbl.ClassName
	if not amt then amt = 1 end
	
	for i = 1, #ply.Chest do
		if not ply.Chest[i] then
			return true, i
		end
		
		if ply.Chest[i].Item == 0 then
			return true, i
		end

	end
	
	if #ply.Chest < ply:GetMaxStorage() then return true, false end
	
	return false, false
	
end