AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
ENT.AddAmount = 30

function ENT:Initialize()
	if GetGlobalInt("Game") != "Mercenaries" then
		self:Remove()
	end
	self.Entity:SetModel("models/hourglass.mdl")	
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_NONE)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:SetNoDraw(true)

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
	if key == "Time"  then
		self.AddAmount = value
		self.SetTime = true
	end
end
function ENT:OnRemove()
end
function ENT:OnRestore()
end
function ENT:PhysicsCollide(data,physobj)
end
function ENT:PhysicsSimulate(phys,deltatime) 
end
function ENT:PhysicsUpdate(phys) 
end
function ENT:Think() 
	if GetGlobalInt("Mode") == "On" && !self.Drawn then
		self:SetNoDraw(false)
		self:SetCollisionGroup(GROUP_INTERACTIVE)
		self:SetColor(255,230,150,105)
		self.Drawn = true
	end
end
function ENT:Touch(ent) 
	if ent:GetClass() == "player" && GetGlobalInt("Mode") == "On" then
		if !self.SetTime then
			self.AddAmount = math.random(30,120)
		end
		self:EmitSound("physics/glass/glass_sheet_break1.wav",100,100)
		SetGlobalInt("Re2_CountDown", GetGlobalInt("Re2_CountDown") + self.AddAmount)
		self:Remove()
	end
end
function ENT:UpdateTransmitState(Entity)
end
function ENT:Use(activator,caller)
end
