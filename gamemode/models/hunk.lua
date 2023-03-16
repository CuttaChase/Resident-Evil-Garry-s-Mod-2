local MODEL = {}

MODEL.ClassName = "hunk" 
MODEL.Name = "Hunk"
MODEL.Category = "Models"
MODEL.Model = "models/vinrax/player/re2/hunk.mdl"
MODEL.Price = 100000
MODEL.Restrictions = {

	["superadmin"] = true,
	["donor"] = true,
	["donor_moderator"] = true,

}

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