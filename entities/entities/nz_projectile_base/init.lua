AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.Damage = 4
ENT.DamageType = DMG_ACID
ENT.Time = 1.5

ENT.PainSound1 = Sound("player/pl_pain7.wav")
ENT.PainSound2 = Sound("player/pl_pain6.wav")
ENT.PainSound3 = Sound("player/pl_pain5.wav")

ENT.ImpactSound1 = Sound("physics/flesh/flesh_squishy_impact_hard1.wav")
ENT.ImpactSound2 = Sound("physics/flesh/flesh_squishy_impact_hard2.wav")
ENT.ImpactSound3 = Sound("physics/flesh/flesh_squishy_impact_hard3.wav")
ENT.ImpactSound4 = Sound("physics/flesh/flesh_squishy_impact_hard4.wav")

ENT.Type = "anim"

function ENT:Initialize()

	self:DrawShadow(false)
	self:PhysicsInitSphere(1)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:SetMass(1)
		phys:SetBuoyancyRatio(0.002)
		phys:EnableMotion(true)
		phys:Wake()
	end
	
	SafeRemoveEntityDelayed( self, (self.Time) ) 
	
end

function ENT:Think()
end

function ENT:Explode()
end

function ENT:DealDamage( ent, damage, type )
	local dmg = DamageInfo()
		dmg:SetDamageType(type)
		ent:TakeDamageInfo(dmg, self.Owner)
		ent:TakeDamage(damage, self.Owner)
end

function ENT:PainSound( ent )
	local painsounds = {}
		painsounds[1] = (self.PainSound1)
		painsounds[2] = (self.PainSound2)
		painsounds[3] = (self.PainSound3)
		ent:EmitSound( painsounds[math.random(1,3)] )
end

function ENT:ImpactSound( ent )
	local sounds = {}
		sounds[1] = (self.ImpactSound1)
		sounds[2] = (self.ImpactSound2)
		sounds[3] = (self.ImpactSound3)
		sounds[4] = (self.ImpactSound4)
		self:EmitSound( sounds[math.random(1,4)], 60 )
end

function ENT:HitSound( ent )
	local sounds = {}
		sounds[1] = (self.ImpactSound1)
		sounds[2] = (self.ImpactSound2)
		sounds[3] = (self.ImpactSound3)
		sounds[4] = (self.ImpactSound4)
		ent:EmitSound( sounds[math.random(1,4)], 60 )
end

function ENT:PhysicsCollide(data, physobj)
	if  ( self:IsValid() ) then
		if SERVER then
		self:ImpactSound()

		local ent = data.HitEntity
			if ( ent and ent:IsValid() and ent:IsPlayer() ) or ( ent and ent:IsValid() and ent:IsNPC() ) then
			
			self:DealDamage( ent, self.Damage, self.DamageType )
			self:PainSound( ent )
			self:HitSound( self )
			SafeRemoveEntity( self ) 
			
			else
			
			local normal = data.OurOldVelocity:GetNormalized()
			local DotProduct = data.HitNormal:Dot(normal * -1)
			physobj:SetVelocityInstantaneous((2 * DotProduct * data.HitNormal + normal) * math.max(100, data.Speed) * 0.9)
			
			end
	
			if ent and ent:IsValid() and ent:GetClass() == "prop_physics" then
			ent:TakeDamage(	(self.Damage) / 2, self)	
			end
	
		end
	end
end
