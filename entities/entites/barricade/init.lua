AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
    if self:GetModel() == nil or self:GetModel() == "models/error.mdl" then
       	self:SetModel("models/props_wasteland/barricade002a.mdl")
    end
	self:SetSolid(SOLID_VPHYSICS)
	if self:Health() <= 0 then
		self:SetHealth(100)
	end
	timer.Simple(3, function()
		if IsValid(self) then
			local ghost = ents.Create("prop_physics")
			ghost:SetModel(self:GetKeyValues()["Model"] or self:GetModel())
			ghost:SetAngles(self:GetAngles())
			ghost:Spawn()
			ghost:SetHealth(self:Health())
			ghost:SetCollisionGroup(11)	

			local max, min = ghost:GetCollisionBounds()

			ghost:SetPos(self:GetPos() )

			local phys = ghost:GetPhysicsObject()
			if IsValid(phys) then
				phys:EnableMotion(false)
			end

			self:Remove()
			ghost.isCade = true
			ghost:DropToFloor()
		end
	end)
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
