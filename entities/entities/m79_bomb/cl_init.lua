include('shared.lua')
ENT.Spawnable			= false
ENT.AdminSpawnable		= false
ENT.RenderGroup 		= RENDERGROUP_OPAQUE

function ENT:Draw()
	self.Entity:DrawModel()
end

function ENT:Think()
	local effectdata = EffectData()
 		effectdata:SetOrigin( self.Entity:LocalToWorld( Vector(0,0,self.Entity:OBBMins().z) ) )
 		//effectdata:SetAngle( self.Entity:GetForward() ) 
 		effectdata:SetScale( .9 )

	self.SmokeTimer = self.SmokeTimer or 0

	if ( self.SmokeTimer > CurTime() ) then return end

	self.SmokeTimer = CurTime() + 0.0001

	local vOffset = self.Entity:LocalToWorld( Vector(0,0,self.Entity:OBBMins().z) )

	local vNormal = (vOffset - self.Entity:GetPos()):GetNormalized()

	local emitter = ParticleEmitter( vOffset )

		local particle = emitter:Add( "particles/smokey", vOffset )
		particle:SetVelocity(VectorRand()*12)
		particle:SetGravity(Vector(5,5,3))
		particle:SetDieTime(math.Rand(2,2.5))
		particle:SetStartAlpha(math.Rand(40,50))
		particle:SetEndAlpha(0)
		particle:SetStartSize(math.Rand(9,14))
		particle:SetEndSize(math.Rand(35,45))
		particle:SetRoll(math.Rand(200,300))
		particle:SetRollDelta(math.Rand(-1,1))
		particle:SetColor(100,100,100)
		if self:GetNWString("Class") == "Ice" then
			particle:SetColor(200,200,225)
		elseif self:GetNWString("Class") == "Flame" then
			particle:SetColor(150,40,40)
		end
		particle:SetAirResistance(5)

	emitter:Finish()
end
