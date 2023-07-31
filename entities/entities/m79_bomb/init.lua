AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	util.PrecacheSound("weapons/m79/explode.wav")
	self.Entity:SetModel("models/weapons/w_grenlaunch_m79_thrown.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
end

function ENT:OnTakeDamage(dmginfo)
end
function ENT:StartTouch(ent) 

end
function ENT:EndTouch(ent)
end
function ENT:AcceptInput(name,activator,caller)

end

function ENT:Effect()
	local explode = ents.Create("env_explosion")
	explode:SetPos(self:GetPos())
	explode.Class = self:GetNWString("Class")
	explode.Owner = self.Owner
	explode:Spawn()
	explode:SetKeyValue("iMagnitude","100")
	if explode.Class == "Flame" then
		explode:SetKeyValue("iMagnitude","75")
	elseif explode.Class == "Ice" then
		explode:SetKeyValue("iMagnitude","50")
	end
	explode:Fire("Explode",0,0)
	explode:EmitSound("weapons/m79/explode.wav",500,100)
end

function ENT:KeyValue(key,value)
end
function ENT:OnRemove()
end
function ENT:OnRestore()
end
function ENT:PhysicsCollide(data,physobj)

	if data.Speed > 75 and data.DeltaTime > 0.3 then
	
			local LastSpeed = data.OurOldVelocity:Length()
			local NewVelocity = physobj:GetVelocity()
			
			local TargetVelocity = NewVelocity + (LastSpeed*0.2)*NewVelocity:GetNormalized()
			physobj:SetVelocity(TargetVelocity)

			self:Effect()
			self:Remove()
	end
	
end
function ENT:PhysicsSimulate(phys,deltatime) 
end
function ENT:PhysicsUpdate(phys) 
end
function ENT:Think() 
end
function ENT:Touch(ent) 
end
function ENT:UpdateTransmitState(Entity)
end
function ENT:Use(activator,caller)
	
end
