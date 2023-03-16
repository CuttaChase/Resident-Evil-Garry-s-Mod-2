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
		
		local phys = self:GetPhysicsObject()
			if phys:IsValid() then
				phys:EnableMotion( true )
				phys:EnableGravity( true )
				phys:Wake()
			end
		--[[
			timer.Simple(8, function() 
				if ( self:IsValid() ) then 

					SafeRemoveEntity( self )
				end
			end)
		--]]
		
	end
	
end

function ENT:Think()
end

if CLIENT then

	function ENT:Draw()
		self:DrawModel()
	end
	
end
