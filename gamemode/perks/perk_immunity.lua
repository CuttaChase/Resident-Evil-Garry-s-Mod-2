
local PERK = {}

PERK.ClassName = "perk_immunity"
PERK.Name = "perk_immunity"
PERK.Desc = "perk_immunity"
PERK.Category = "DonorPerks"
PERK.Model = "models/props_lab/jar01a.mdl"
PERK.Price = 100000

PERK.Restrictions = {
	["superadmin"] = true,
	["donor"] = true,
}

function PERK:ServerInitialize( ply )

	-- Put any external hook.Add's here

end

function PERK:ClientInitialize( ply )

end


function PERK:OnEquip( ply )
	ply:SetNWInt("Immunity", 101)
end

function PERK:OnRemove( ply )
	ply:SetNWInt("Immunity", 50)
end

function PERK:Think( ply )

end

perky.Register( PERK )
