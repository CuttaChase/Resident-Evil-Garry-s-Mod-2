AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	local itemnumber = math.random(1,50)
	local entity = ents.Create("item_3ammo")
	if (itemnumber >= 1 && itemnumber <= 2) then
		entity = ents.Create("item_spray")
	elseif (itemnumber >= 3 && itemnumber <= 8) then
		entity = ents.Create("item_pammo")
	elseif (itemnumber >= 9 && itemnumber <= 12) then
		entity = ents.Create("item_bammo")
	elseif (itemnumber >= 13 && itemnumber <= 17) then
		entity = ents.Create("item_mammo")
	elseif (itemnumber >= 18 && itemnumber <= 22) then
		entity = ents.Create("item_rammo")
	elseif (itemnumber >= 23 && itemnumber <= 27) then
		entity = ents.Create("item_3ammo")
	elseif (itemnumber >= 28 && itemnumber <= 30) then
		entity = ents.Create("item_c4")
	elseif (itemnumber >= 29 && itemnumber <= 31) then
		entity = ents.Create("item_landmine")
	elseif (itemnumber >= 31 && itemnumber <= 32) then
		entity = ents.Create("item_pammo")
	elseif (itemnumber >= 34 && itemnumber <= 37) then
		entity = ents.Create("item_rherb")
	elseif (itemnumber >= 39 && itemnumber <= 41) then
		entity = ents.Create("item_gherb")
	elseif (itemnumber >= 42 && itemnumber <= 45) then
		entity = ents.Create("item_bherb")
	elseif (itemnumber >= 46 && itemnumber <= 48) then
		entity = ents.Create("item_barricade")
	elseif (itemnumber >= 49 && itemnumber <= 50) then
		entity = ents.Create("item_barricade")
	end
	entity:SetPos(self:GetPos())
	entity:SetAngles(self:GetAngles())
	entity:Activate()
	entity:Spawn()
	self:Remove()
end
function ENT:OnTakeDamage(dmginfo)
end
function ENT:StartTouch(ent)
end
function ENT:EndTouch(ent)
end
function ENT:AcceptInput(name,activator,caller)
end
function ENT:KeyValue(key,value)
end
function ENT:OnRemove()
end
function ENT:OnRestore()
end
function ENT:PhysicsCollide(data,physobj)
end
function ENT:PhysicsSimulate(phys,deltatime)
end
function ENT:PhysicsUpdate(phys)
end
function ENT:Think()
end
function ENT:Touch(hitEnt)
end
function ENT:UpdateTransmitState(Entity)
end
function ENT:Use(activator,caller)
end
