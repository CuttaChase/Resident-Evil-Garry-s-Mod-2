if (CLIENT) then
	SWEP.PrintName			= "#re2gm_wpn_quadrpg"
	SWEP.Slot				= 4
	SWEP.SlotPos			= 0
	SWEP.IconLetter			= "C"
	SWEP.DrawAmmo 			= true
	SWEP.DrawCrosshair 		= false
	SWEP.CSMuzzleFlashes 	= true
	SWEP.SwayScale			= 1.0
	SWEP.BobScale			= 1.0
	killicon.AddFont("weapon_Quad","CSKillIcons",SWEP.IconLetter,Color(255,80,0,255))
end
SWEP.perk_fasthands_alreadydid = nil

SWEP.HoldType 			= "rpg"
DEFINE_BASECLASS( "gunbase" )
SWEP.ViewModelFOV		= 50
SWEP.ViewModelFlip		= false
SWEP.ViewModel      = "models/weapons/v_rpc.mdl"
SWEP.WorldModel   = "models/weapons/w_rpc.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("weapons/stinger_fire1.wav")
SWEP.Primary.Recoil			= 4
SWEP.Primary.Damage			= 20
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.07
SWEP.Primary.ClipSize		= 4
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Delay			= 1.5
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "RPG_Round"

SWEP.ReloadSpeed = 5
SWEP.Primary.ReloadingTime = 1
SWEP.Primary.NumberofShots = 1 
SWEP.Primary.Spread = 0.2
SWEP.Primary.Force = -20                     
SWEP.Primary.KickUp = 3.9                      
SWEP.Primary.KickSides = 3.6

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Delay		= 1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"


function SWEP:Deploy()
	self.Weapon:SetNetworkedBool("Ironsights", false)
	self.Weapon:SetNetworkedBool("reloading", false)
	self.Weapon:SetNetworkedBool("VBEnabled", true)
	self:SetIronsights( false )
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)

	return BaseClass.Deploy( self )
end

function SWEP:PrimaryAttack()
	if (!self:CanPrimaryAttack()) then return end
		self.Weapon:EmitSound(self.Primary.Sound,50, 100)
	if SERVER then
		

		local bomb = ents.Create("quad_rocket")

		local v = self:GetOwner():GetShootPos()
		v = v + self:GetOwner():GetForward() * 20
		v = v + self:GetOwner():GetRight() * 20
		v = v + self:GetOwner():GetUp() * -5
		bomb:SetPos( v )
		bomb:SetAngles(self:GetOwner():GetAimVector():Angle())
		bomb:Spawn()
		bomb.Owner = self:GetOwner()
		bomb:GetPhysicsObject():ApplyForceCenter(self:GetOwner():GetForward() * 10000)
	end
	local rnda = self.Primary.KickUp * -1
	local rndb = self.Primary.KickSides * math.random(-0.5, 0.5)
	self.Owner:ViewPunch( Angle( rnda,rndb,rndb ) )
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.ReloadingTime )
	self:TakePrimaryAmmo(1)

end


function SWEP:CanPrimaryAttack()
	if self.Weapon:Clip1() <= 0 then
		self:EmitSound("Weapon_Pistol.Empty")
		self:SetNextPrimaryFire(CurTime() + 0.2)
		self:Reload()
		return false
	end
	return true
end

function SWEP:SetIronsights( b )
	self.Weapon:SetNetworkedBool( "Ironsights", b )
end

SWEP.NextSecondaryAttack = 0

function SWEP:SecondaryAttack()
	if ( !self.IronSightsPos ) then return end
	if ( self.NextSecondaryAttack > CurTime() ) then return end

	bIronsights = !self.Weapon:GetNetworkedBool( "Ironsights", false )

	if bIronsights == true then
		self.Primary.Cone = self.Primary.Cone * self.IMultiplier
		if SERVER then
			GAMEMODE:SetPlayerSpeed(self:GetOwner(),self.Owner.Speeds.Run /3,self.Owner.Speeds.Sprint/3)
		end

	else
		self.Primary.Cone = self.Primary.Cone / self.IMultiplier
		if SERVER then
			GAMEMODE:SetPlayerSpeed(self:GetOwner(),self:GetOwner():GetNWInt("Speed"),self:GetOwner():GetNWInt("Speed"))
		end
	end
	self:SetIronsights( bIronsights )

	self.NextSecondaryAttack = CurTime() + 0.3
end

function SWEP:OnRestore()

	self.NextSecondaryAttack = 0
	self:SetIronsights( false )

end

function SWEP:Reload()

	if self:GetNWBool("reloading") then return false end
	if self:Clip1() >= self.Primary.ClipSize then return false end
	if self:Clip1() < self.Primary.ClipSize && self:GetOwner():GetAmmoCount(self.Primary.Ammo) > 0  then
	
		self:SetIronsights( false )
		self.Weapon:SendWeaponAnim(ACT_VM_RELOAD)
		self.Owner:GetViewModel():SetPlaybackRate(2.3 / self.ReloadSpeed)
		self:SetNWBool("reloading", true)
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

function SWEP:CanSecondaryAttack()
	if self.Weapon:GetNetworkedBool("reloading") then return end

	return true
end

function SWEP:ContextScreenClick(aimvec,mousecode,pressed,ply)
end
function SWEP:OnRemove()
end
function SWEP:OwnerChanged()
end
function SWEP:Ammo1()
	return self.Owner:GetAmmoCount(self.Weapon:GetPrimaryAmmoType())
end
function SWEP:Ammo2()
	return self.Owner:GetAmmoCount(self.Weapon:GetSecondaryAmmoType())
end

