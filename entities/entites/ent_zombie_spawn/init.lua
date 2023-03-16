AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
end

function ENT:OnTakeDamage(dmginfo)
end
function ENT:StartTouch(ent)
end
function ENT:EndTouch(ent)
end
function ENT:AcceptInput(name,activator,caller)
	if Name == "Enable" || Name == "enable" then
		self.Disabled = false
	elseif Name == "Disable" || Name == "Disable" then
		self.Disabled = true
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
function ENT:KeyValue( key, value )
	if key == "Disabled" || key == "disabled" then
		self.Disabled = true
	end
end
