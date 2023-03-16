
INVENTORY = {}

function INVENTORY:Add( ply, class, amt )

	local Inv = ply.inventory
	if not amt then amt = 1 end
	if class == "item_money" then return end 
	for k,v in pairs(Inv) do
		if v.Item == 0 then
			ply.inventory[k].Item = class
			ply.inventory[k].Amount = amt
			SendDataToAClient(ply)
			return
		elseif v.Item == class && v.Amount + amt <= item.GetItem(v.Item).Max then
			ply.inventory[k].Item = class
			ply.inventory[k].Amount = ply.inventory[k].Amount + amt
			SendDataToAClient(ply)
			return
		end
	end
end

function INVENTORY:Use( ply, itemtbl, slot )

	if itemtbl.CanUse then
		local canuse = itemtbl:CanUse( ply )
		if not canuse then return end
	end

	local deduct = itemtbl:OnUsed( ply )
	if deduct then
		ply.inventory[ slot ].Amount = ply.inventory[ slot ].Amount - 1
	end

	if ply.inventory[ slot ].Amount < 1 then
		self:ResetSlot( ply, slot )
	end

	SendDataToAClient( ply )

end

function INVENTORY:CustomOption( ply, itemtbl, slot, func )

	local deduct = itemtbl.CustomOptions[ func ]( ply )
	if deduct then
		ply.inventory[ slot ].Amount = ply.inventory[ slot ].Amount - 1
	end

	if ply.inventory[ slot ].Amount < 1 then
		self:ResetSlot( ply, slot )
	end

	SendDataToAClient( ply )

end


function INVENTORY:Drop( ply, itemtbl, slot )

	if itemtbl.OnDropped then
		itemtbl:OnDropped( ply )
	end

	ply.inventory[ slot ].Amount = ply.inventory[ slot ].Amount - 1

	if itemtbl.WeaponClass then
		ply:StripWeapon( itemtbl.WeaponClass )
	end

	self:Throw( ply, itemtbl )

	ply:EmitSound("items/ammocrate_open.wav")

	if ply.inventory[ slot ].Amount < 1 then
		self:ResetSlot( ply, slot )
	end

	SendDataToAClient( ply )

end

function INVENTORY:Throw( ply, itemtbl )

	local tr = ply:GetEyeTrace()
	local DropedEnt
	DropedEnt = ents.Create( itemtbl.ClassName )
	DropedEnt:SetAngles(ply:EyeAngles())
	DropedEnt:Spawn()

	if itemtbl.ClassName == "item_c4" || itemtbl.ClassName == "item_landmine" || itemtbl.ClassName == "item_barricade" then
		DropedEnt:SetPos(ply:GetPos())
	else
		DropedEnt:SetPos(ply:EyePos() + (ply:GetAimVector() * 30))
	end
	--[[
	if itemtbl.WeaponClass then
		if ply.Upgrades[ itemtbl.ClassName ] then
			DropedEnt.Upgrades = {}
			DropedEnt.Upgrades = ply.Upgrades[ itemtbl.ClassName ]
			ply.Upgrades[ itemtbl.ClassName ] = nil
		end
	end
	]]--
	timer.Simple(600, function()
		if not DropedEnt:IsValid() then return end
		DropedEnt:Remove()
	end )

end

function INVENTORY:Give( ply, itemtbl, slot )
	local trace = ply:GetEyeTraceNoCursor()
	if !trace.Hit then return end
	if trace.HitWorld then return end
	if trace.Entity:IsPlayer() && trace.Entity:Team() == TEAM_HUNK then
		local target = trace.Entity
		//if ply:GetPos():Distance(rply:GetPos()) >> 90 then return end
		if self:HasRoom( target, itemtbl, 1 ) then
			self:Add( target, itemtbl.ClassName, 1 )
			target:PrintMessage( HUD_PRINTTALK, ply:Nick().." gave you a ".. itemtbl.Name )
			ply:PrintMessage( HUD_PRINTTALK, "You gave " .. target:Nick() .. " a ".. itemtbl.Name )
			self:RemoveItem( ply, itemtbl, slot )

			-----------
				if itemtbl.WeaponClass then
				if ply.Upgrades[ itemtbl.ClassName ] then
					DropedEnt.Upgrades = {}
					DropedEnt.Upgrades = ply.Upgrades[ itemtbl.ClassName ]
					ply.Upgrades[ itemtbl.ClassName ] = nil
				end
				end
			-----------
		end
	end
end

function INVENTORY:HasRoom( ply, itemtbl, amt )

	local Inv = ply.inventory
	local name = itemtbl.ClassName

	if not amt then amt = 1 end

	for k,v in pairs( Inv ) do
		if v.Item == 0 then
			return true
		end

		if v.Item == name then
			if v.Amount + amt <= itemtbl.Max then
				return true
			end
		end

	end

	return false

end

function INVENTORY:RemoveItem( ply, itemtbl, slot )

	ply.inventory[ slot ].Amount = ply.inventory[ slot ].Amount - 1

	if itemtbl.WeaponClass then
		ply:StripWeapon( itemtbl.WeaponClass )
	end

	if ply.inventory[ slot ].Amount < 1 then
		self:ResetSlot( ply, slot )
	end

	SendDataToAClient( ply )

end

function INVENTORY:UpgradeWeapon( ply, command, args )
	local upg = ply.Upgrades
	local weapon = args[1]
	local trait = args[2]
	local cash = tonumber(ply:GetNWInt("Money"))
	local pwr = upg[weapon].plvl
	local acc = upg[weapon].alvl
	local clp = upg[weapon].clvl
	local fis = upg[weapon].slvl
	if trait == "Power" && upg[weapon].plvl != UpgradeLevels[weapon].MaxPower then
		if cash >= UpgPrices[weapon].Power[pwr] then
			ply:SetNWInt("Money", cash - UpgPrices[weapon].Power[pwr])
			upg[weapon].plvl = upg[weapon].plvl + 1
		end
	elseif trait == "Accuracy" && upg[weapon].alvl != UpgradeLevels[weapon].MaxAccuracy  then
		if  cash >= UpgPrices[weapon].Accuracy[acc] then
		ply:SetNWInt("Money", cash - UpgPrices[weapon].Accuracy[acc])
		upg[weapon].alvl = upg[weapon].alvl + 1
		end
	elseif trait == "ClipSize" && upg[weapon].clvl != UpgradeLevels[weapon].MaxClipSize then
		if  cash >= UpgPrices[weapon].ClipSize[clp] then
			ply:SetNWInt("Money", cash - UpgPrices[weapon].ClipSize[clp])
			upg[weapon].clvl = upg[weapon].clvl + 1
		end
	elseif trait == "FiringSpeed" && upg[weapon].slvl != UpgradeLevels[weapon].MaxFiringSpeed  then
		if  cash >= UpgPrices[weapon].FiringSpeed[fis] then
			ply:SetNWInt("Money", cash - UpgPrices[weapon].FiringSpeed[fis])
			upg[weapon].slvl = upg[weapon].slvl + 1
		end
	end
	if ply:GetActiveWeapon():GetClass() == Weapons[weapon].Weapon then
		ply:GetActiveWeapon():Update()
	end
end
concommand.Add("UpgradeWeapon",INVENTORY.UpgradeWeapon)

function INVENTORY:ResetSlot( ply, slot )
	ply.inventory[ slot ] = { Item = 0, Amount = 0 }
end
