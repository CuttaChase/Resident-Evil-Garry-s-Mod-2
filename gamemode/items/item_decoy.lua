local ITEM = {}
decoytime = 6
-- NEVER REPEAT CLASS NAMES
ITEM.ClassName = "item_decoy"
ITEM.WeaponClass = false

ITEM.Name = "decoy"
ITEM.Desc = "decoy"
ITEM.Model = "models/weapons/w_grenade.mdl"

ITEM.Price = 750
ITEM.Max = 1

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
	local DropedEnt = ents.Create("item_decoy")
	DropedEnt:SetPos(ply:EyePos() + (ply:GetAimVector() * 30))
	DropedEnt.Armed = true
	DropedEnt:Spawn()
	DropedEnt.Owner = ply
	DropedEnt:SetOwner(ply)
	if tr.HitWorld then
		local vFlushPoint = tr.HitPos - ( tr.HitNormal * 512 )	// Find a point that is definitely out of the object in the direction of the floor
		vFlushPoint = DropedEnt:NearestPoint( vFlushPoint )			// Find the nearest point inside the object to that point
		vFlushPoint = DropedEnt:GetPos() - vFlushPoint				// Get the difference
		vFlushPoint = tr.HitPos + vFlushPoint					// Add it to our target pos
		DropedEnt:SetPos( vFlushPoint )
	else
		DropedEnt:SetPos( ply:GetPos() )
	end

	return true

end

function ITEM:OnDropped( ply )

end

ITEM.CustomOptions = {
--[[
	[ "Suicide" ] = function( ply )
		local ed = EffectData()
		ed:SetOrigin( ply:GetPos() )
		util.Effect( "Explosion", ed, true, true )
		util.BlastDamage( ply, ply, ply:GetPos(), 200, 200)
		return true
	end,
]]
}


item.Register( ITEM )
