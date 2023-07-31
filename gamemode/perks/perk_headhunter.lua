
local PERK = {}

PERK.ClassName = "perk_headhunter" 
PERK.Name = "perk_headhunter"
PERK.Desc = "perk_headhunter"
PERK.Category = "Defense"
PERK.Model = "models/Gibs/HGIBS.mdl"
PERK.Price = 100000

PERK.Restrictions = false

function PERK:ServerInitialize()

	hook.Add( "OnNPCKilled", "REGmod.HeadFunter", function( zombie, att, inf )
		if att:HasPerk( "perk_headhunter" ) then
			att:SetHealth( math.Clamp( att:Health() + 5, 0, att:GetMaxHealth() ) )
		end
	end )

end

function PERK:ClientInitialize()

end

function PERK:OnEquip( ply )

end

function PERK:OnRemove( ply )

end

function PERK:Think( ply )

end

perky.Register( PERK )