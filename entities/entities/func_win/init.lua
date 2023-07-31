AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
end

function ENT:AcceptInput(name,activator,caller)
	if name == "Win" then
		GAMEMODE:BaseEndGame()
	end
end

function ENT:KeyValue(key,value)
end
function ENT:OnRemove()
end
function ENT:Think() 
end
