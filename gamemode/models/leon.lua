local MODEL = {}

MODEL.ClassName = "leon" 
MODEL.Name = "Leon S Kennedy"
MODEL.Category = "Models"
MODEL.Model = "models/vinrax/player/re2/leon_normal.mdl"
MODEL.Price = 100000
--[[
MODEL.Restrictions = {

	["superadmin"] = true,
	["admin"] = true,

}
]]
MODEL.Restrictions = nil

function MODEL:ServerInitialize( ply )

end

function MODEL:ClientInitialize( ply )

end

function MODEL:OnEquip( ply )

		if ply:Team() == TEAM_HUNK then
	
			if not ply._OldModel then
				ply._OldModel = ply:GetModel()
			end
		
			timer.Simple(1, function() ply:SetModel(self.Model) end)
		end
end

function MODEL:OnRemove( ply )
		if ply:Team() == TEAM_HUNK then
			if ply._OldModel then
				ply:SetModel(ply._OldModel)
			end
		end
end

function MODEL:Think( ply )

end

damodels.Register( MODEL )