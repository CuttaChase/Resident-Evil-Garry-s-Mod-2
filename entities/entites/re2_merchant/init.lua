AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
	self:SetModel("models/re2_merchant.mdl")
	self:SetSequence("ragdoll")
	self:PhysicsInitBox(self:GetPos() + Vector(-10,-10,0) ,self:GetPos() + Vector(10,10,80))
	self:SetMoveType(MOVETYPE_NONE)
	//self:DropToFloor()
end

function ENT:KeyValue(key,value)
end

function ENT:SetType(strType)
end

function ENT:SetAmount(varAmount)
end

function ENT:Use(activator, caller)
--[[
	if activator:IsPlayer()  && GetGlobalString("Mode") == "Merchant" && activator.CanUse then
		activator:ConCommand("RE2_MerchantMenu")
		activator.CanUse = false
		timer.Simple(1, function() activator.CanUse = true end)
	end
--]]
end