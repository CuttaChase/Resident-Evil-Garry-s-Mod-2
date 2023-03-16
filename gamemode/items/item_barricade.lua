local ITEM = {}

-- NEVER REPEAT CLASS NAMES
ITEM.ClassName = "item_barricade"
ITEM.WeaponClass = false

ITEM.Name = "Barricade"
ITEM.Desc = "Keep Zombies Out"
ITEM.Model = "models/props_wasteland/barricade002a.mdl"

ITEM.Price = 150
ITEM.Max = 1

ITEM.Category = "Supplies"

ITEM.Loot = true
ITEM.LootChance = 0.1

ITEM.Restrictions = false

function ITEM:CanUse( ply )

	if not ply.PrevBarricade then return true end
	return !ply.PrevBarricade:IsValid()

end

function ITEM:OnUsed( ply )
	------------------------------

	local ghost = ents.Create("item_barricade") 
	ghost:Spawn()
	ghost.Owner = ply
	ghost:SetOwner(ply)
	local anglefix = Angle(0,-90,0)
	ghost:SetAngles(ply:GetAngles() + anglefix)
	ghost:SetHealth(25)
	ghost:SetModelScale(1)
	ghost:SetCollisionGroup(11)
	ghost:SetSolid(SOLID_VPHYSICS)

	----------------------------------

	ghost:SetPos( ply:GetPos() + Vector(0,0,28) )

	----------------------------------

	local phys = ghost:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end
	

	ghost.isCade = true


	--[[

	
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
	
	ply.PrevBarricade = DropedEnt

	]]--
	
	return true


end

function ITEM:OnDropped( ply )
	
end

item.Register( ITEM )

 