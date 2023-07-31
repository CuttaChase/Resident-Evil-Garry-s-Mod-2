AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
	self:SetModel("models/chest.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:DropToFloor()
end

function ENT:KeyValue(key,value)
end

function ENT:SetType(strType)
end

function ENT:SetAmount(varAmount)
end

function ENT:Use(activator, caller)

	if activator:IsPlayer() && GetGlobalString("Mode") == "Merchant" && activator.CanUse then
		net.Start( "REGmod.OpenMerchant" )
		net.Send(activator)
		activator.CanUse = false
		timer.Simple(1, function() activator.CanUse = true end)
	end

end