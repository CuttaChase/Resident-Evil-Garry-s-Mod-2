AddCSLuaFile()
--zzDEFINE_BASECLASS( "tfa_gun_base" )
SWEP.HoldType = "pistol"
SWEP.Primary.ReloadingTime = 1

--[[---------------------------------------------------------
	This draws the weapon info box
-----------------------------------------------------------]]
function SWEP:PrintWeaponInfo( x, y, alpha )

	if ( self.DrawWeaponInfoBox == false ) then return end

	if (self.InfoMarkup == nil ) then
		local str
		local title_color = "<color=230,230,230,255>"
		local text_color = "<color=150,150,150,255>"

		str = "<font=HudSelectionText>"
		if ( self.Author != "" ) then str = str .. title_color .. "#re2gm_wpn_base_author</color>\t" .. text_color .. self.Author .. "</color>\n" end
		if ( self.Contact != "" ) then str = str .. title_color .. "#re2gm_wpn_base_contact</color>\t" .. text_color .. self.Contact .. "</color>\n\n" end
		if ( self.Purpose != "" ) then str = str .. title_color .. "#re2gm_wpn_base_purpose</color>\n" .. text_color .. self.Purpose .. "</color>\n\n" end
		if ( self.Instructions != "" ) then str = str .. title_color .. "#re2gm_wpn_base_inst</color>\n" .. text_color .. self.Instructions .. "</color>\n" end
		str = str .. "</font>"

		self.InfoMarkup = markup.Parse( str, 250 )
	end

	surface.SetDrawColor( 60, 60, 60, alpha )
	surface.SetTexture( self.SpeechBubbleLid )

	surface.DrawTexturedRect( x, y - 64 - 5, 128, 64 )
	draw.RoundedBox( 8, x - 5, y - 6, 260, self.InfoMarkup:GetHeight() + 18, Color( 60, 60, 60, alpha ) )

	self.InfoMarkup:Draw( x + 5, y + 5, nil, nil, alpha )

end

function SWEP:Initialize()

	self:SetWeaponHoldType(self.HoldType)
	self.Weapon:SetNetworkedBool("Ironsights", false)
	self.Weapon:SetNetworkedBool("reloading", false)
	self.Weapon:SetNetworkedBool("VBEnabled", true)
	self:SetIronsights( false )
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	--BaseClass.Initialize( self ) --calls SWEP:Initialize() from weapon_csbasegun

end

function SWEP:Deploy()
	self:SetWeaponHoldType(self.HoldType)
	self:Update()
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	
    --calls SWEP:Deploy() from weapon_csbasegun and returns its result
end

function SWEP:SetIronsights( b )
	self.Weapon:SetNetworkedBool( "Ironsights", b )
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
	return
	
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
	
	if !self.Owner:HasPerk( "perk_fasthands" ) then
		self.perk_fasthands_alreadydid = nil
	end

	if self.Owner:HasPerk( "perk_fasthands" ) then
		if self.perk_fasthands_alreadydid == nil then
			self.perk_fasthands_alreadydid = true
		end
		if self.perk_fasthands_alreadydid == true then
			self.ReloadSpeed = self.ReloadSpeed/1.5
			self.Primary.ReloadingTime = self.Primary.ReloadingTime/1.5
			self.perk_fasthands_alreadydid = false
		end
	elseif self.perk_fasthands_alreadydid != nil && !self.Owner:HasPerk( "perk_fasthands" ) then
		if self.perk_fasthands_alreadydid == false then
			self.ReloadSpeed = self.ReloadSpeed*1.5
			self.Primary.ReloadingTime = self.Primary.ReloadingTime*1.5
			self.perk_fasthands_alreadydid = nil
		end
	end
end

function SWEP:DoubleTap2()

	if self.Owner:HasPerk( "perk_doubletap" ) then
		self.Primary.NumberofShots = 2
		self.Primary.NumberofShots2 = 6
	elseif !self.Owner:HasPerk( "perk_doubletap" ) then
		self.Primary.NumberofShots = 1
		self.Primary.NumberofShots2 = 5
	end
	

end


----------------------------
--Reload
----------------------------
function SWEP:Reload()

	if self:GetNWBool("reloading") then return false end
	if self:Clip1() >= self.Primary.ClipSize then return false end
	if self:Clip1() < self.Primary.ClipSize && self:GetOwner():GetAmmoCount(self.Primary.Ammo) > 0  then
	
		self:SetIronsights( false )
		self.Weapon:SendWeaponAnim(ACT_VM_RELOAD)
		self.Owner:GetViewModel():SetPlaybackRate(2.3 / self.ReloadSpeed)
		self:SetNWBool("reloading", true)
		self.Weapon:SetVar("reloadtimer",CurTime() + self.ReloadSpeed)
		self:GetOwner():AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_HL2MP_GESTURE_RELOAD, true)
		self:SetNextPrimaryFire(CurTime() + self.Primary.ReloadingTime)
		self:SetNextSecondaryFire(CurTime() + self.Primary.ReloadingTime)
	end

end

function SWEP:Think()
	if ( self.Weapon:GetNetworkedBool( "reloading", true ) ) then
		if ( self.Weapon:GetVar( "reloadtimer", 0 ) < CurTime() ) then
				if SERVER then

					if self:IsValid() && !self.Switched then
						if (self:GetOwner():GetAmmoCount(self.Primary.Ammo) + self.Weapon:Clip1()) >= self.Primary.ClipSize then
							if SERVER then
								self:GetOwner():RemoveAmmo(self.Primary.ClipSize - self.Weapon:Clip1()  ,self.Primary.Ammo )
								self.Weapon:SetClip1(self.Primary.ClipSize)
							end
						else
							if SERVER then
								self.Weapon:SetClip1(self:GetOwner():GetAmmoCount(self.Primary.Ammo) + self.Weapon:Clip1())
								self:GetOwner():RemoveAmmo(self:GetOwner():GetAmmoCount(self.Primary.Ammo),self.Primary.Ammo)
							end
						end
						self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
						self:SetNWBool("reloading", false)
					else
						self:SetNWBool("reloading", false)
						self.Switched = false
					end
				end
		end
	end	
end





---------------------------------
function SWEP:CanPrimaryAttack()
	if self.Weapon:Clip1() <= 0 then
		self:EmitSound("Weapon_Pistol.Empty")
		self:SetNextPrimaryFire(CurTime() + 0.2)
		self:Reload()
		return false
	end
	if self.Weapon:GetNetworkedBool("reloading") then
		self.Weapon:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
		self.Weapon:SetNetworkedBool("reloading",false)
		self:SetNextPrimaryFire(CurTime() + self.Primary.ReloadingTime)
		self:EmitSound(self.ReloadSound2)
		return false
	end
	return true
end


function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	local bullet = {}
		bullet.Num = self.Primary.NumberofShots
		bullet.Src = self.Owner:GetShootPos()
		bullet.Dir = self.Owner:GetAimVector()
		bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
		bullet.Tracer = 1
		bullet.TracerName = "Tracer"
		bullet.Force = self.Primary.Force
		bullet.Damage = self.Primary.Damage
		bullet.AmmoType = self.Primary.Ammo
	local rnda = self.Primary.KickUp * -1
	local rndb = self.Primary.KickSides * math.random(-0.5, 0.5)
	self:ShootEffects()
	self.Owner:FireBullets( bullet )
	self.Weapon:EmitSound(self.Primary.Sound, 50, 100, 0.1)
	self.Owner:ViewPunch( Angle( rnda,rndb,rndb ) )
	self:TakePrimaryAmmo(self.Primary.TakeAmmo)
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.ReloadingTime )
	

end