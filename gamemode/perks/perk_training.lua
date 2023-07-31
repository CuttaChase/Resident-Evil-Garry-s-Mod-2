
local PERK = {}

PERK.ClassName = "perk_training" 
PERK.Name = "perk_combattraining"
PERK.Desc = "perk_combattraining"
PERK.Category = "Defense"
PERK.Model = "models/props_lab/binderbluelabel.mdl"
PERK.Price = 15000

PERK.Restrictions = false

function PERK:ServerInitialize( ply )

end

function PERK:ClientInitialize( ply )

end

function PERK:OnEquip( ply )
	ply:SetNWInt("Speed",200)
	ply:SetNWInt("Speed2",200)
end

function PERK:OnRemove( ply )
	ply:SetNWInt("Speed",160)
	ply:SetNWInt("Speed2",160)
end

function PERK:Think( ply )

end

perky.Register( PERK )