AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
    if self:GetModel() == nil or self:GetModel() == "models/error.mdl" then
       	self:SetModel("models/props_wasteland/barricade002a.mdl")
    end
	self:SetSolid(SOLID_VPHYSICS)
	self:SetModelScale(0.5)
	


		self.Entity:PhysicsInit( SOLID_VPHYSICS )
		self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
		self.Entity:SetSolid( SOLID_VPHYSICS )
		self:SetCollisionGroup(20)	
		
		local phys = self:GetPhysicsObject()
			if phys:IsValid() then
				phys:EnableMotion( true )
				phys:EnableGravity( true )
				phys:Wake()
			end
end

function ENT:StartTouch(ent)
end
function ENT:EndTouch(ent)
end
function ENT:AcceptInput(name,activator,caller)
end
function ENT:KeyValue(key,value)
	if key == "Model" or key == "model" then
		self:SetModel(tostring(value))
	end
	if key == "Health" or key == "health" then
		self:SetHealth(tonumber(value))
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

if CLIENT then

	function ENT:Draw()
		self:DrawModel()
	end
	
end