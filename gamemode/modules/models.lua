module( "damodels", package.seeall )

local models = {}
local categories = {}

function Register( tbl )

	if models[ tbl.ClassName ] then
		print( "[MODEL] Failed to register model " .. tbl.Name .. ": Duplicate name! (" .. tbl.ClassName .. ")" )
	end
	
	models[ tbl.ClassName ] = tbl
	
	if SERVER then
		print( "[MODEL] Registered Model: " .. tbl.Name )
		tbl:ServerInitialize()
	end
	
	if CLIENT then
		tbl:ClientInitialize()
	end
	
	if not categories[ tbl.Category ] then
		categories[ tbl.Category ] = true
		if SERVER then
			print( "[MODEL] Registered Category: " .. tbl.Category )
		end
	end
	
end

function GetAll()

	return models

end

function GetCategories()
	return categories
end

function GetData( model )
	return models[ model ]
end

function GetCategoryItems( cat )

	local modellst = {}
	
	for class, data in pairs( models ) do
		if data.Category == cat then
			table.insert( modellst, data )
		end
	end
	
	return modellst

end