include('shared.lua')
ENT.Spawnable			= false
ENT.AdminSpawnable		= false
ENT.RenderGroup 		= RENDERGROUP_OPAQUE

function ENT:Draw()
	self.Entity:DrawModel()
end

function ENT:Think()

	self.SmokeTimer = self.SmokeTimer or 0

	if ( self.SmokeTimer > CurTime() ) then return end

	self.SmokeTimer = CurTime() + 0.0001

	local vOffset = self.Entity:LocalToWorld( Vector(0,0,self.Entity:OBBMins().z) )

	local vNormal = (vOffset - self.Entity:GetPos()):GetNormalized()

	local emitter = ParticleEmitter( vOffset )

		local particle = emitter:Add( "particles/smokey", vOffset )
		particle:SetVelocity(VectorRand()*12)
		particle:SetGravity(Vector(5,5,3))
		particle:SetDieTime(math.Rand(.5,1.5))
		particle:SetStartAlpha(math.Rand(40,50))
		particle:SetEndAlpha(0)
		particle:SetStartSize(math.Rand(4,6))
		particle:SetEndSize(math.Rand(15,22))
		particle:SetRoll(math.Rand(200,300))
		particle:SetRollDelta(math.Rand(-1,1))
		particle:SetColor(100,100,100)
		particle:SetAirResistance(5)

	emitter:Finish()
end
