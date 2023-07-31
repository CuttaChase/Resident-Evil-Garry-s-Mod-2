AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.Trigger = Sound( "weapons/c4/c4_exp_deb2.wav" )

function ENT:Initialize()

	self.Entity:SetModel(item.GetItem( self:GetClass() ).Model)	

	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup(11)



end

function ENT:Think()

	if self.Triggered then return end
	if self.Entity:GetOwner():IsPlayer() then
		for k,g in pairs( ents.FindByClass( "snpc_*" ) ) do
			local dist = g:GetPos():Distance( self.Entity:GetPos() )
			if dist < 100 then
				self.Triggered = true
				self.Entity:EmitSound( self.Trigger )
				self:Asplode()
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
	local damage = 50

	if self.Entity:GetOwner():HasPerk( "perk_explosives" ) then radius = 200 damage = 150 end

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
