
local PERK = {}

PERK.ClassName = "perk_fasthands" 
PERK.Name = "Fast Hands"
PERK.Desc = "Reload and Shoot twice as fast"
PERK.Category = "Attack"
PERK.Model = "models/Items/ammocrate_ar2.mdl"
PERK.Price = 500000

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