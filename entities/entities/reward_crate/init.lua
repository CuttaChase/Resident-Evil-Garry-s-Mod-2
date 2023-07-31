AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.Item = "item_pammo"
ENT.Amount = 1

function ENT:Initialize()

	self.Entity:SetModel("models/items/item_item_crate.mdl")
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetHealth(1)
end
function ENT:OnTakeDamage(dmginfo)

	self.Entity:GibBreakClient(self.Entity:GetPos())
	self:Remove()
end
function ENT:StartTouch(ent)
end
function ENT:EndTouch(ent)
end
function ENT:AcceptInput(name,activator,caller)
end
function ENT:KeyValue(key,value)
	if key == "ItemCount" && value != nil then
		self.Amount = value
	elseif key == "ItemClass" && value != nil then
		self.Item = value
	end
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
