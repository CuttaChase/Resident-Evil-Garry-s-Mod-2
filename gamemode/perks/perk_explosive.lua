
local PERK = {}

PERK.ClassName = "perk_explosives" 
PERK.Name = "perk_explosivesexpert"
PERK.Desc = "perk_explosivesexpert"
PERK.Category = "Attack"
PERK.Model = "models/Items/ammocrate_ar2.mdl"
PERK.Price = 25000

PERK.Restrictions = false


function PERK:ServerInitialize( ply )

	-- Put any external hook.Add's here

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