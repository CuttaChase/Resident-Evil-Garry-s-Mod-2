AddCSLuaFile()

ENT.Type = "anim"
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions	= ""

ENT.Spawnable 		= false
ENT.AdminSpawnable 	= false
ENT.RenderGroup 		= RENDERGROUP_OPAQUE





--stats
ENT.PrintName		= "Prop"
ENT.Category 		= ""

ENT.Model = ("")

if SERVER then

	function ENT:Initialize()
	
		self.Entity:SetModel(item.GetItem( self:GetClass() ).Model)	
		self.Entity:PhysicsInit( SOLID_VPHYSICS )
		self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
		self.Entity:SetSolid( SOLID_VPHYSICS )
		self:SetCollisionGroup(11)	
		
	
		--[[
			timer.Simple(8, function() 
				if ( self:IsValid() ) then 

					SafeRemoveEntity( self )
				end
			end)
		--]]
		
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
	local damage = 100
	
	if self.Entity:GetOwner():HasPerk( "perk_explosives" ) then radius = 300 damage = 200 end
	
	util.BlastDamage( self.Entity, self.Entity:GetOwner(), self.Entity:GetPos(), radius, damage )
	self.Entity:EmitSound("weapon_AWP.Single",800,500)
	self.Entity:Remove()
	
end

function ENT:Think()
end

if CLIENT then

	function ENT:Draw()
		self:DrawModel()
	end
	
end
