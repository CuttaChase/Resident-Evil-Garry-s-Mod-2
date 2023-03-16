
local PERK = {}

PERK.ClassName = "perk_beginner" 
PERK.Name = "Beginner's Luck"
PERK.Desc = "Gain 100% more health but gain 75% less money"
PERK.Category = "Defense"
PERK.Model = "models/props_c17/doll01.mdl"
PERK.Price = 500

PERK.Restrictions = false

function PERK:ServerInitialize( ply )

end

function PERK:ClientInitialize( ply )

end

function PERK:OnEquip( ply )
	ply.DefaultHealth = ply:GetMaxHealth()
	ply:SetMaxHealth( ply:GetMaxHealth()*2 )
	ply:SetHealth( ply:Health() + ply:GetMaxHealth() )
end

function PERK:OnRemove( ply )
	ply:SetMaxHealth( ply:GetMaxHealth()/2 )
	ply:SetHealth( ply:Health() - ply:GetMaxHealth() )
	if ply:Health() < 0 then
		ply:SetHealth( 1 )
	end
end

function PERK:Think( ply )

end

perky.Register( PERK )