module( "item", package.seeall )

local itemlist = {}
local categories = {}

function Register( tbl )

	if itemlist[ tbl.ClassName ] then
		print( "[ITEM] Failed to register item " .. tbl.Name .. ": Duplicate class name! (" .. tbl.ClassName .. ")" )
	end

	itemlist[ tbl.ClassName ] = tbl
	if SERVER then
		print( "[ITEM] Registered Item: " .. tbl.Name )
	end

	if not categories[ tbl.Category ] then
		categories[ tbl.Category ] = true
		if SERVER then
			print( "[ITEM] Registered Category: " .. tbl.Category )
		end
	end

end

function GetAll()


	for _, items in pairs( itemlist ) do

		local data = {}
		data.Name = weapon.Name
		data.Desc = weapon.Desc
		data.Entity = weapon.Entity
		data.Class = weapon.Class
		data.Price = weapon.Price
		data.Model = weapon.Model
		data.Weight = weapon.Weight
		data.CamPos = weapon.CamPos
		data.CamOrigin = weapon.CamOrigin
		data.Type = weapon.Type
		data.Starter = weapon.Starter
		data.Achievement = weapon.Achievement

		table.insert( WeaponList, data )

	end


	return itemlist

end

function IsValidWeapon( item )
	if not itemlist[ item ] then return false end
	return itemlist[ item ].WeaponClass
end

function GetCategories()
	if categories=="" then print("blank cat.") end
	return categories
end

function GetWeaponTables( class )
	for _, data in pairs( itemlist ) do
		if not data.WeaponClass then continue end
		if data.WeaponClass == class then
			return data
		end
	end
end

function GetItem( item )
	return itemlist[ item ]
end

function GetCategoryItems( cat )

	local items = {}

	for class, data in pairs( itemlist ) do
		if data.Category == cat then
			table.insert( items, data )
		end
	end

	return items

end
