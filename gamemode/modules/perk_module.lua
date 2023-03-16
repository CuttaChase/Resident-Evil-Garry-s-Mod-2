
PERKS = {}

function PERKS:BuyPerk( ply, perktbl )

	ply.OwnedPerks[ perktbl.ClassName ] = true
	ply:AddMoney( -1*perktbl.Price )
	SendDataToAClient( ply )
	
end

function PERKS:EquipPerk( ply, perktbl, slot )

	for i=1, #ply.EquippedPerks do
		if ply.EquippedPerks[ i ] == perktbl.ClassName and slot != i then
			ply.EquippedPerks[ i ] = 0
			ply.EquippedPerks[ slot ] = perktbl.ClassName
			perktbl:OnEquip( ply )
			SendDataToAClient( ply )
			return
		end
	end
	
	ply.EquippedPerks[ slot ] = perktbl.ClassName
	perktbl:OnEquip( ply )	
	SendDataToAClient( ply )
	
end

function PERKS:RemovePerk( ply, perktbl )

	for i=1, #ply.EquippedPerks do
		if ply.EquippedPerks[ i ] == perktbl.ClassName then
			ply.EquippedPerks[ i ] = 0
			perktbl:OnRemove( ply )
			SendDataToAClient( ply )
			return
		end
	end

end