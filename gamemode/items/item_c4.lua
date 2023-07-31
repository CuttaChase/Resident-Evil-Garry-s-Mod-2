local ITEM = {}

-- NEVER REPEAT CLASS NAMES
ITEM.ClassName = "item_c4"
ITEM.WeaponClass = false

ITEM.Name = "C4"
ITEM.Desc = "C4"
ITEM.Model = "models/weapons/w_c4_planted.mdl"

ITEM.Price = 150
ITEM.Max = 2

ITEM.Category = "Supplies"

ITEM.Loot = true
ITEM.LootChance = 0.1

ITEM.Restrictions = false

function ITEM:CanUse( ply )

	if not ply.PrevC4 then return true end
	return !ply.PrevC4:IsValid()

end

function ITEM:OnUsed( ply )

	local vStart = ply:GetShootPos()
	local vForward = ply:GetAimVector()

	local trace = {}
	trace.start = vStart
	trace.endpos = vStart + (vForward * 160)
	trace.filter = ply

	local tr = util.TraceLine( trace ) 
	local DropedEnt = ents.Create("item_c4") 
	DropedEnt:SetPos(ply:EyePos() + (ply:GetAimVector() * 30)) 
	DropedEnt.Armed = true 
	DropedEnt:Spawn() 
	DropedEnt.Owner = ply
	DropedEnt:SetOwner(ply)
	if tr.HitWorld then
		local vFlushPoint = tr.HitPos - ( tr.HitNormal * 512 )
		vFlushPoint = DropedEnt:NearestPoint( vFlushPoint )			
		vFlushPoint = DropedEnt:GetPos() - vFlushPoint				
		vFlushPoint = tr.HitPos + vFlushPoint					
		DropedEnt:SetPos( vFlushPoint )
	else
		DropedEnt:SetPos( ply:GetPos() )
	end
	
	ply.PrevC4 = DropedEnt
	
	return true

end

function ITEM:OnDropped( ply )

end

item.Register( ITEM )

 