AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self.Entity:SetModel(item.GetItem( self:GetClass() ).Model)
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup(11)

	local phys = self.Entity:GetPhysicsObject()
	if IsValid( phys ) then
		phys:Wake()
	end
end
function ENT:OnTakeDamage(dmginfo)
end
function ENT:StartTouch(ent)
end
function ENT:EndTouch(ent)
end
function ENT:AcceptInput(name,activator,caller)
end
function ENT:KeyValue(key,value)
end
function ENT:OnRemove()
end
function ENT:OnRestore()
end
function ENT:PhysicsCollide(data,physobj)
end
function ENT:Think()
end
function ENT:Touch(hitEnt)
end
function ENT:UpdateTransmitState(Entity)
end

money = {
	100,200,300,400,500,600,700,800,900,1000,
	150,250,350,450,550,650,750,850,950,1050,
}
function ENT:Use(activator,caller)
	self.Entity:SetUseType( SIMPLE_USE )
	local ranmon = table.Random(money)
	caller:AddMoney(ranmon)
	caller:ChatPrint(translate.ClientGet("you_found_x_dollars", ranmon))
	self.Entity:Remove()
end
