if (CLIENT) then
	SWEP.PrintName			= "Glock 18"
	SWEP.Slot				= 1
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "c"
	SWEP.DrawAmmo 			= true
	SWEP.DrawCrosshair 		= false	
	SWEP.CSMuzzleFlashes 	= true
	SWEP.SwayScale			= 1.0
	SWEP.BobScale			= 1.0
	killicon.AddFont("weapon_glock18","CSKillIcons",SWEP.IconLetter,Color(255,80,0,255))
end

DEFINE_BASECLASS( "gunbase" )

SWEP.ViewModelFOV		= 62
SWEP.ViewModelFlip		= true
SWEP.ViewModel			= "models/weapons/v_pist_glockre.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_glock18.mdl"
SWEP.HoldType 			= "pistol"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("weapons/glockre/glock18-1.wav")
SWEP.Primary.Recoil			= .5
SWEP.Primary.Damage			= 17
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.ClipSize		= 20
SWEP.Primary.Delay			= 0.15
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "pistol"
SWEP.Primary.ReloadingTime = 1
SWEP.ReloadSpeed = 3
SWEP.Primary.NumberofShots = 1 
SWEP.Primary.Spread = 0.12
SWEP.Primary.Force = -20                     
SWEP.Primary.KickUp = 0.9                      
SWEP.Primary.KickSides = 0.6

SWEP.Primary.TakeAmmo = 1 
SWEP.ReloadSound = ""  
SWEP.ReloadSound2 = "weapons/smg1/smg1_reload.wav"
SWEP.perk_fasthands_alreadydid = nil
SWEP.Changing = false

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Delay = 0.25
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Item = "item_glock18"

function SWEP:Deploy()
	self.Weapon:SetNetworkedBool("Ironsights", false)
	self.Weapon:SetNetworkedBool("reloading", false)
	self.Weapon:SetNetworkedBool("VBEnabled", true)
	self:SetIronsights( false )
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)

	return BaseClass.Deploy( self )
end

function SWEP:SecondaryAttack()
	if self.Changing then return end
	self.Changing = true
	timer.Simple(0.5, function() self.Changing = false end)
	self:EmitSound("Weapon_Pistol.Empty")
	if self.Primary.Automatic != true then
		self.Primary.Automatic = true 
		self:GetOwner():PrintMessage(HUD_PRINTCENTER,"Switched to automatic")
	else 
		self.Primary.Automatic = false
		self:GetOwner():PrintMessage(HUD_PRINTCENTER,"Switched to single fire")
	end
	
end

function SWEP:CanSecondaryAttack()
if self.Changing != false then return end
	if self.Weapon:Clip2() <= 0 then
		self.Weapon:EmitSound("Weapon_Pistol.Empty")
		self.Weapon:SetNextSecondaryFire(CurTime() + 0.2)
		return false
	end
	return true
end

function SWEP:CanPrimaryAttack()
if self.Changing != false then return false end
	if self.Weapon:Clip1() <= 0 then
		self:EmitSound("Weapon_Pistol.Empty")
		self:SetNextPrimaryFire(CurTime() + 0.2)
		self:Reload()
		return false
	end
	return true
end

function SWEP:Reload()

	if self:GetNWBool("reloading") then return false end
	if self:Clip1() >= self.Primary.ClipSize then return false end
	if self:Clip1() < self.Primary.ClipSize && self:GetOwner():GetAmmoCount(self.Primary.Ammo) > 0  then
	
		self:SetIronsights( false )
		self.Weapon:SendWeaponAnim(ACT_VM_RELOAD)
		self.Owner:GetViewModel():SetPlaybackRate(2.3 / self.ReloadSpeed)
		self:SetNWBool("reloading", true)
		self:EmitSound(self.ReloadSound2)
		self.Weapon:SetVar("reloadtimer",CurTime() + self.ReloadSpeed)
		self:GetOwner():SetAnimation(PLAYER_RELOAD)
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
