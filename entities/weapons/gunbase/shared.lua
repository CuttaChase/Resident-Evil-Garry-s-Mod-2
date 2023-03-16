AddCSLuaFile()
--zzDEFINE_BASECLASS( "tfa_gun_base" )
SWEP.Primary.ReloadingTime = 1
function SWEP:Initialize()

	--BaseClass.Initialize( self ) --calls SWEP:Initialize() from weapon_csbasegun

end

function SWEP:Deploy()

	if not self.ItemData then
		local tbl = item.GetWeaponTables( self:GetClass() )
		if not tbl then
			self.ItemData = {}
		else
			self.ItemData = tbl
		end
	end
	
	if self.ItemData.OnDeploy then
		self.ItemData:OnDeploy( self.Owner, self.Weapon )
		self:LoadPerks()
	end
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	
    --calls SWEP:Deploy() from weapon_csbasegun and returns its result
end

function SWEP:Update()

	if not self.ItemData then
		local tbl = item.GetWeaponTables( self:GetClass() )
		if not tbl then
			self.ItemData = {}
		else
			self.ItemData = tbl
		end
	end

	if self.ItemData.OnDeploy then
		self.ItemData:OnDeploy( self.Owner, self.Weapon )
		self:LoadPerks()
	end
	return true
end


function SWEP:LoadPerks()

	self:DoubleTap()
	self:DoubleTap2()
	self:FastHands()

end

function SWEP:DoubleTap()
--[[
	if self.Owner:HasPerk( "perk_doubletap" ) then
		self.Primary.Delay = self.Primary.Delay*2
	elseif !self.Owner:HasPerk( "perk_doubletap" ) then
		self.Primary.Delay = self.Primary.Delay
	end
	
	return self.Primary.Delay
--]]
end

function SWEP:FastHands()

	if self.Owner:HasPerk( "perk_fasthands" ) then
		self.Primary.Delay = self.Primary.ReloadingTime/2
	elseif !self.Owner:HasPerk( "perk_fasthands" ) then
		self.Primary.Delay = self.Primary.ReloadingTime
	end
	
	return self.Primary.Delay

end

function SWEP:DoubleTap2()

	if self.Owner:HasPerk( "perk_doubletap" ) then
		self.Primary.NumberofShots = 2
	elseif !self.Owner:HasPerk( "perk_doubletap" ) then
		self.Primary.NumberofShots = 1
	end
	
	return self.Primary.NumberofShots

end