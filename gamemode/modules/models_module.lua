
MODELS = {}

function MODELS:BuyModel( ply, modeltbl )

	ply.OwnedModels[ modeltbl.ClassName ] = true
	ply:AddMoney( -1*modeltbl.Price )
	SendDataToAClient( ply )
	
end

function MODELS:EquipModel( ply, modeltbl, slot )

	
			ply.EquippedModel = modeltbl.ClassName
			modeltbl:OnEquip( ply )
			SendDataToAClient( ply )
	
	
	--ply.EquippedModel[ slot ] = modeltbl.ClassName
	--modeltbl:OnEquip( ply )	
	--SendDataToAClient( ply )
	
end

function MODELS:RemoveModel( ply, modeltbl )

	
			ply.EquippedModel = 0
			modeltbl:OnRemove( ply )
			ply:SetModel(table.Random(mdls2))
			SendDataToAClient( ply )
	


end