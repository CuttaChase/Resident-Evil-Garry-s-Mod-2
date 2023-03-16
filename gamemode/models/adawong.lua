local MODEL = {}

MODEL.ClassName = "adawong" 
MODEL.Name = "ADA Wong"
MODEL.Category = "Models"
MODEL.Model = "models/vinrax/player/re2/ada_wong.mdl"
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