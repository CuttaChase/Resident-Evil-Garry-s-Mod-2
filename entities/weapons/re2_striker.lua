
--[[













ADDED CODE














]]





-------------------
SWEP.HoldType = "shotgun"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = true
SWEP.UseHands = true
SWEP.ViewModel 			= "models/weapons/v_shot_strike.mdl"
SWEP.WorldModel 		= "models/weapons/w_shot_strike.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
----------------------


--------------------------------

SWEP.IronSightsPos = Vector (3.628, -2.1104, 3.1663)
SWEP.IronSightsAng = Vector (-1.5758, 3.0083, 0.0085)





--[[










	--------------------------------------------
	--------------------------------------------
	All Below Is Copy and paste with adjustments
	--------------------------------------------
	--------------------------------------------









]]
DEFINE_BASECLASS( "gunbase" )
SWEP.Slot = 4
SWEP.SlotPos = 1
SWEP.Category = "Resident Evil 2 Swep"                          
SWEP.PrintName = "#re2gm_wpn_str7"                        
SWEP.Author = "@CuttaChaseBeats" 
SWEP.Purpose = "#re2gm_wpn_str7_purpose"         
SWEP.Instructions = "#re2gm_wpn_str7_inst"              
SWEP.Contact = "cuttachasebeats@icloud.com"

SWEP.Primary.Damage = 5
SWEP.Primary.ClipSize		= 8					// Size of a clip
SWEP.Primary.Automatic		= false				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "buckshot"
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.ReloadingTime = 1.2
SWEP.ReloadSpeed = 1.5
SWEP.Primary.NumberofShots2 = 5 
SWEP.Primary.Spread = 2.1
SWEP.Primary.Force = -20                     
SWEP.Primary.KickUp = 2.9                      
SWEP.Primary.KickSides = 0.6
SWEP.Primary.Sound			= Sound("weapons/stiker/m3-2.wav")
SWEP.Primary.TakeAmmo = 1 
SWEP.Primary.Delay = 0.5   
SWEP.perk_fasthands_alreadydid = nil


SWEP.ReloadSound = "weapons/m3/shotgun_insertshell.mp3"  
SWEP.ReloadSound2 = "weapons/m3/shotgun_pump.wav"

SWEP.Secondary.ClipSize		= 0					// Size of a clip
SWEP.Secondary.DefaultClip	= 0				// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo			= "none"



function SWEP:Deploy()
	self.Weapon:SetNetworkedBool("Ironsights", false)
	self.Weapon:SetNetworkedBool("reloading", false)
	self.Weapon:SetNetworkedBool("VBEnabled", true)
	self:SetIronsights( false )
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)

	return BaseClass.Deploy( self )
end


--------------------------------------------------------------------
--[[
	IRON SIGHTS
]]

function SWEP:SetIronsights( b )
	self.Weapon:SetNetworkedBool( "Ironsights", b )
end

function SWEP:GetViewModelPosition(pos, ang)
	local IRONSIGHT_TIME = 0.5

	if (!self.IronSightsPos) then return pos, ang end
	

	local bmIron = self.Weapon:GetNetworkedBool("Ironsights")
	
	if (bmIron != self.bmLastIron) then
	
		self.bmLastIron = bmIron 
		self.fmIronTime = CurTime()
		
		if (bmIron) then 
			self.SwayScale 	= -0.3
			self.BobScale 	= 0.2
			self.DrawCrosshair = false

		else 
			self.SwayScale 	= -2
			self.BobScale 	= 1.0
			self.DrawCrosshair = false

		end
	
	end
	
	
	local fmIronTime = self.fmIronTime or 0

	if (!bmIron and fmIronTime < CurTime() - IRONSIGHT_TIME) then 
		return pos, ang 
	end
	
	local Mul = 1.0
	
	if (fmIronTime > CurTime() - IRONSIGHT_TIME) then
	
		Mul = math.Clamp((CurTime() - fmIronTime) / IRONSIGHT_TIME, 0, 1)
		
		if (!bmIron) then Mul = 1 - Mul end
	
	end

	local Offset	= self.IronSightsPos
	
	if (self.IronSightsAng) then
	
		ang = ang * 1
		ang:RotateAroundAxis(ang:Right(), self.IronSightsAng.x * Mul)
		ang:RotateAroundAxis(ang:Up(), self.IronSightsAng.y * Mul)
		ang:RotateAroundAxis(ang:Forward(), self.IronSightsAng.z * Mul)
		
	
	end
	
	local Right 	= ang:Right()
	local Up 		= ang:Up()
	local Forward 	= ang:Forward()
	
	

	pos = pos + Offset.x * Right * Mul
	pos = pos + Offset.y * Forward * Mul
	pos = pos + Offset.z * Up * Mul

	return pos, ang
	
end

SWEP.NextSecondaryAttack = 0

function SWEP:SecondaryAttack()
	if ( !self.IronSightsPos ) then return end
	if ( self.NextSecondaryAttack > CurTime() ) then return end

	bIronsights = !self.Weapon:GetNetworkedBool( "Ironsights", false )

	self:SetIronsights( bIronsights )

	self.NextSecondaryAttack = CurTime() + 0.3
end

--[[
	IRON SIGHTS
]]
----------------------------------------------------------------------------------


----------------------------
--Reload
----------------------------
function SWEP:Reload()

	if self:GetNWBool("reloading") then return false end
	if self:Clip1() >= self.Primary.ClipSize then return false end
	if self:Clip1() < self.Primary.ClipSize && self:GetOwner():GetAmmoCount(self.Primary.Ammo) > 0  then
	
		self:SetIronsights( false )
		self.Weapon:SendWeaponAnim(ACT_VM_RELOAD)
		self:SetNWBool("reloading", true)
		self.Weapon:SetVar("reloadtimer",CurTime() + self.Primary.ReloadingTime)
		self:GetOwner():SetAnimation(PLAYER_RELOAD)
		self:SetNextPrimaryFire(CurTime() + self.Primary.ReloadingTime)
		self:SetNextSecondaryFire(CurTime() + self.Primary.ReloadingTime)
	end

end

function SWEP:Think()

	if ( self.Weapon:GetNetworkedBool( "reloading", true ) ) then
		if ( self.Weapon:GetVar( "reloadtimer", 0 ) < CurTime() ) then
			
			// Finsished reload -
			if ( self.Weapon:Clip1() >= self.Primary.ClipSize || self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0 ) then
				self.Weapon:SetNetworkedBool( "reloading", false )
				
					self:EmitSound(self.ReloadSound2)
				
				return
			end
			
			// Next cycle
			self.Weapon:SetVar( "reloadtimer", CurTime() + self.Primary.ReloadingTime )
			
			// Add ammo
			if SERVER then
			self.Owner:RemoveAmmo( 1, self.Primary.Ammo, false )
			
			self.Weapon:SetClip1(  self.Weapon:Clip1() + 1 )
			self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )
			end
			self:EmitSound(self.ReloadSound)
			
			// Finish filling, final pump
			if ( self.Weapon:Clip1() >= self.Primary.ClipSize || self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0 ) then
				self.Weapon:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH )
			else
			
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
		bullet.Num = self.Primary.NumberofShots2
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
	self.Weapon:EmitSound(Sound(self.Primary.Sound), 50)
	self.Owner:ViewPunch( Angle( rnda,rndb,rndb ) )
	self:TakePrimaryAmmo(self.Primary.TakeAmmo)
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.ReloadingTime )

end