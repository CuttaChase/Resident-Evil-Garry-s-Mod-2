AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
end

function ENT:AcceptInput(name,activator,caller)
	if name == "KZ" then
	print("zombies reset.")
		for k, v in pairs( ents.FindByClass( "snpc_*" ) ) do
			v:TakeDamage( 9999, nil, nil )
		end
	end
end

function ENT:KeyValue(key,value)
end
function ENT:OnRemove()
end
function ENT:Think()
end
