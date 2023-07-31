if (CLIENT) then
	SWEP.PrintName			= "Tactical Spas-12"
	SWEP.Slot				= 4
	SWEP.SlotPos			= 0
	SWEP.DrawAmmo 			= true
	SWEP.DrawCrosshair 		= false
	SWEP.IconLetter			= "B"
 	killicon.AddFont( "weapon_striker12", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
end
SWEP.HoldType 			= "shotgun"
DEFINE_BASECLASS( "gunbase" )

SWEP.ViewModelFOV		= 62
SWEP.ViewModelFlip		= true
SWEP.ViewModel 			= "models/weapons/v_shot_spas12.mdl"
SWEP.WorldModel 		= "models/weapons/w_shotgun.mdl"


SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("weapons/spas12/XM1014-2.wav")
SWEP.ReloadSound = Sound("weapons/m3/shotgun_insertshell.mp3")  
SWEP.ReloadSound2 = Sound("weapons/m3/shotgun_pump.wav")
SWEP.Primary.Recoil			= 5
SWEP.Primary.Damage			= 10
SWEP.Primary.NumShots		= 5
SWEP.Primary.Cone			= 0.2
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.ClipSize		= 5
SWEP.Primary.Delay			= 1.3
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "buckshot"
SWEP.Primary.ReloadingTime = 1
SWEP.ReloadSpeed = 1
SWEP.Primary.NumberofShots2 = 5 
SWEP.Primary.Spread = 2.4
SWEP.Primary.Force = -20                     
SWEP.Primary.KickUp = 2.9                      
SWEP.Primary.KickSides = 0.6
SWEP.Primary.TakeAmmo = 1 
SWEP.perk_fasthands_alreadydid = nil

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Item = "item_spas12"



SWEP.IronSightsPos = Vector (2.1826, -0.2859, 0.9807)
SWEP.IronSightsAng = Vector (0, 0, 0)
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
	self.Weapon:EmitSound(Sound(self.Primary.Sound), 40)
	self.Owner:ViewPunch( Angle( rnda,rndb,rndb ) )
	self:TakePrimaryAmmo(self.Primary.TakeAmmo)
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.ReloadingTime )

end

--------------------------------------------------------------------
--[[
	IRON SIGHTS
]]

function SWEP:SetIronsights( b )
	self.Weapon:SetNetworkedBool( "Ironsights", b )
end

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




