module( "perky", package.seeall )

local perks = {}
local categories = {}

function Register( tbl )

	if perks[ tbl.ClassName ] then
		print( "[PERK] Failed to register perk " .. tbl.Name .. ": Duplicate name! (" .. tbl.ClassName .. ")" )
	end
	
	perks[ tbl.ClassName ] = tbl
	
	if SERVER then
		print( "[PERK] Registered Perk: " .. tbl.Name )
		tbl:ServerInitialize()
	end
	
	if CLIENT then
		tbl:ClientInitialize()
	end
	
	if not categories[ tbl.Category ] then
		categories[ tbl.Category ] = true
		if SERVER then
			print( "[PERK] Registered Category: " .. tbl.Category )
		end
	end
	
end

function GetAll()

	return perks

end

function GetCategories()
	return categories
end

function GetData( perk )
	return perks[ perk ]
end

function GetCategoryItems( cat )

	local perklst = {}
	
	for class, data in pairs( perks ) do
		if data.Category == cat then
			table.insert( perklst, data )
		end
	end
	
	return perklst

end