AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.Trigger = Sound( "weapons/c4/c4_exp_deb2.wav" )

function ENT:Initialize()

	self.Entity:SetModel( "models/weapons/w_grenade.mdl" )

	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup(11)

end

wascalled = false
rannumber = tostring(math.random(1,50))
function ENT:decoyfunction()
	if wascalled == false then
timer.Create(rannumber,.5,100,function()
	self.Entity:EmitSound("HL1/fvox/beep.wav",60)

end)
			timer.Simple(decoytime,function()
				wascalled = false
				self.Triggered = true
				self.Entity:EmitSound( self.Trigger )
				self:Asplode()
				timer.Destroy(rannumber)
			end)
		end
end



function ENT:Think()
	if self.Triggered then return end
	if self.Entity:GetOwner():IsPlayer() then
		for k,g in pairs( ents.FindByClass( "snpc_*" ) ) do
			if g:IsValid() then
				g:SetEnemy( self.Entity,true )
				self:decoyfunction()
				wascalled = true
			end
		end
	end
end

function ENT:Asplode()

	local trace = {}
	trace.start = self.Entity:GetPos() + Vector(0,0,20)
	trace.endpos = trace.start + Vector( 0, 0, -200 )
	trace.filter = self.Entity

	local tr = util.TraceLine( trace )

	local ed = EffectData()
	ed:SetOrigin( self.Entity:GetPos() )
	util.Effect( "Explosion", ed, true, true )

	if tr.HitWorld then
		local ed = EffectData()
		ed:SetOrigin( tr.HitPos )
		ed:SetMagnitude( 0.8 )
		util.Decal( "Scorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal )
	end

	local radius = 200
	local damage = 400

	if self.Entity:GetOwner():HasPerk( "perk_explosives" ) then radius = 400 damage = 800 end

	util.BlastDamage( self.Entity, self.Entity:GetOwner(), self.Entity:GetPos(), radius, damage )
	self.Entity:EmitSound("weapon_AWP.Single",800,500)
	self.Entity:Remove()

end

function ENT:OnRemove()
end
function ENT:OnRestore()
end
function ENT:PhysicsCollide(data,physobj)
end

hook.Add("EntityTakeDamage","NoExpDamage",function( target, dmginfo )

	if ( target:IsPlayer() and dmginfo:IsExplosionDamage() && (dmginfo.Owner or nil) == target) then
		dmginfo:ScaleDamage( 0 ) // Damage is now half of what you would normally take.
	end

end)
