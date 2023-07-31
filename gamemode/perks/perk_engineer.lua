
local PERK = {}

PERK.ClassName = "perk_engineer" 
PERK.Name = "perk_engineer"
PERK.Desc = "perk_engineer"
PERK.Category = "Defense"
PERK.Model = "models/props_lab/binderbluelabel.mdl"
PERK.Price = 10000

PERK.Restrictions = {
	["superadmin"] = true,
	["donor"] = true,
	["donor_moderator"] = true,
}

function PERK:ServerInitialize( ply )

end

function PERK:ClientInitialize( ply )

end

function PERK:OnEquip( ply )

end

function PERK:OnRemove( ply )

end

function PERK:Think( ply )

end

perky.Register( PERK )