local ITEM = {}

-- NEVER REPEAT CLASS NAMES
ITEM.ClassName = "item_barricade"
ITEM.WeaponClass = false

ITEM.Name = "barricade"
ITEM.Desc = "barricade"
ITEM.Model = "models/props_wasteland/barricade002a.mdl"

ITEM.Price = 150
ITEM.Max = 4

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
	if ply:HasPerk("perk_engineer") then
		ghost:SetHealth(200)
		for k,v in pairs(ents.FindInSphere(ghost:GetPos(), 80)) do
			if v:IsValid() and v:IsPlayer() then
				local healthdelay = 0
				if CurTime() <= healthdelay then return end
				ghost:SetHealth(ghost:Health() + 1)
				healthdelay = CurTime() + 5
			end
		end
	else
		ghost:SetHealth(100)
	end
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