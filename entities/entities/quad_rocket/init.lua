AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self.Entity:SetModel("models/weapons/w_missile_Closed.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetGravity(0)
	self.Entity:EmitSound("sound/weapons/rpg/rocket_1.wav",500,0)
end

function ENT:OnTakeDamage(dmginfo)
end
function ENT:StartTouch(ent) 

end
function ENT:EndTouch(ent)
end
function ENT:AcceptInput(name,activator,caller)

end

function ENT:Explode()
	self.Entity:EmitSound("sound/ambient/explosions/explode_4.wav",500,0)
	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	effectdata:SetNormal(self:GetPos())
	effectdata:SetScale(0.5)
	util.Effect("eff_QuadBoom",effectdata)
	local explode = ents.Create("env_explosion")
	explode:SetPos(self:GetPos())
	explode.Class = self:GetNWString("Class")
	explode.Owner = self.Owner
	explode.Suicidal = true
	explode:Spawn()
	explode:SetKeyValue("iMagnitude","200")
	explode:Fire("Explode",0,0)
	util.ScreenShake(self:GetPos(),15,5,0.6,1200)
	self:Remove()
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

			self:Explode()
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
