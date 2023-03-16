if (CLIENT) then
	SWEP.PrintName			= "Quad Rocket Launcher"
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
if (SERVER) then
	AddCSLuaFile("shared.lua")
end
SWEP.HoldType 			= "rpg"
SWEP.Base				= "weapon_basegun_re"

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

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Delay		= 1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Item = "item_quadrpg"

function SWEP:Deploy()
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	if SERVER then
		GAMEMODE:SetPlayerSpeed(self:GetOwner(),self:GetOwner():GetNWInt("Speed")/2,self:GetOwner():GetNWInt("Speed")/2)
	end
end

function SWEP:Holster(wep)
	if SERVER then
		GAMEMODE:SetPlayerSpeed(self:GetOwner(),self:GetOwner():GetNWInt("Speed"),self:GetOwner():GetNWInt("Speed"))
	end
	return true
end

function SWEP:PrimaryAttack()
	if (!self:CanPrimaryAttack()) then return end
		self.Weapon:EmitSound(self.Primary.Sound,100, 100)
	if SERVER then
		self.Weapon:TossWeaponSound();

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

	self:GetOwner():ViewPunch(Angle( math.Rand(-1,-1) * self.Primary.Recoil,math.Rand(-1,1) *self.Primary.Recoil,0))
	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:TakePrimaryAmmo(1)

 	if (game.SinglePlayer() && SERVER) || CLIENT then
 		self.Weapon:SetNetworkedFloat("LastShootTime",CurTime())
 	end
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
