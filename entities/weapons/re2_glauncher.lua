if (CLIENT) then
	SWEP.PrintName			= "m79 Grenade Launcher"
	SWEP.Slot				= 3
	SWEP.SlotPos			= 0
	SWEP.IconLetter			= "C"
	SWEP.DrawAmmo 			= true
	SWEP.DrawCrosshair 		= false
	SWEP.CSMuzzleFlashes 	= true
	SWEP.SwayScale			= 1.0
	SWEP.BobScale			= 1.0
	killicon.AddFont("weapon_m79","CSKillIcons",SWEP.IconLetter,Color(255,80,0,255))
end
if (SERVER) then
	AddCSLuaFile("shared.lua")
end
SWEP.HoldType 			= "shotgun"

DEFINE_BASECLASS( "gunbase" )

SWEP.ViewModelFOV		= 62
SWEP.ViewModelFlip		= true
SWEP.ViewModel			= "models/weapons/v_grenlaunch_m79.mdl"
SWEP.WorldModel			= "models/weapons/w_grenlaunch_m79.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("weapons/m79/m79_fire.wav")
SWEP.Primary.Recoil			= 1
SWEP.Primary.Damage			= 20
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.07
SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Delay			= 1.5
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "CombineCannon"

SWEP.Mag = 1
SWEP.ReloadSpeed = 2
SWEP.Primary.ReloadingTime = 1
SWEP.Primary.NumberofShots = 1 
SWEP.Primary.Spread = 0.2
SWEP.Primary.Force = -20                     
SWEP.Primary.KickUp = 3.9                      
SWEP.Primary.KickSides = 3.6
SWEP.perk_fasthands_alreadydid = nil


SWEP.Secondary.ClipSize		= 99999
SWEP.Secondary.DefaultClip	= 99999
SWEP.Secondary.Delay		= 1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"


SWEP.AmmoTypeTable = { "CombineCannon","GaussEnergy","Battery"}
SWEP.AmmoNumber = 1

SWEP.Primary.Ammo			= SWEP.AmmoTypeTable[SWEP.AmmoNumber]

function SWEP:Deploy()
	self:GetOwner():SetNWString("RE2_DisplayAmmotype", self.AmmoTypeTable[self.AmmoNumber])
	self.Weapon:SetNetworkedBool("Ironsights", false)
	self.Weapon:SetNetworkedBool("reloading", false)
	self.Weapon:SetNetworkedBool("VBEnabled", true)
	self:SetIronsights( false )
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	self:GetOwner():EmitSound("weapons/m79/m79_draw.wav",100,100)
	return BaseClass.Deploy( self )
	
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

function SWEP:PrimaryAttack()
	if (!self:CanPrimaryAttack()) then return end

	if SERVER then
		local bomb = ents.Create("m79_bomb")

		local v = self:GetOwner():GetShootPos()
		v = v + self:GetOwner():GetForward() * 5
		v = v + self:GetOwner():GetRight() * 9
		v = v + self:GetOwner():GetUp() * -8.5
		bomb:SetPos( v )
		bomb:SetAngles(self:GetOwner():GetAimVector():Angle() - Angle(90,0,00))
		if self.AmmoNumber == 2 then
			bomb:SetNWString("Class","Flame")
		elseif self.AmmoNumber == 3 then
			bomb:SetNWString("Class","Ice")
		else
			bomb:SetNWString("Class","Explosive")
		end
		bomb:Spawn()
		bomb.Owner = self:GetOwner()
		bomb:GetPhysicsObject():ApplyForceCenter(self:GetOwner():GetForward() * 5000)

	end
	self:GetOwner():EmitSound(self.Primary.Sound,100, 100)
	local rnda = self.Primary.KickUp * -1
	local rndb = self.Primary.KickSides * math.random(-0.5, 0.5)
	self.Owner:ViewPunch( Angle( rnda,rndb,rndb ) )
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.ReloadingTime )
	self:TakePrimaryAmmo(1)
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
		self:GetOwner():EmitSound("weapons/m79/m79_close.wav",100,100)
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

function SWEP:SecondaryAttack()
	if ( self.NextSecondaryAttack > CurTime() ) then return end
	if	self.AmmoNumber >= table.Count(self.AmmoTypeTable) then
		self.AmmoNumber = 1
	else
		self.AmmoNumber = self.AmmoNumber + 1
	end
		self:GetOwner():EmitSound("weapons/m79/m79_close.wav",50,100)

	self.Primary.Ammo = self.AmmoTypeTable[self.AmmoNumber]


	self:GetOwner():SetNWString("RE2_DisplayAmmotype", self.AmmoTypeTable[self.AmmoNumber])
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)

	self.NextSecondaryAttack = CurTime() + self.Secondary.Delay

end


if CLIENT then
	function SWEP:DrawHUD()
			local x = ScrW() / 2.0
			local y = ScrH() / 2.0
			
			surface.DrawLine(x,y ,x,y + y/5 )
			surface.DrawRect(x-40,(y ),80,1)
			surface.DrawRect(x-30,(y )+ (y/20),60,1)
			surface.DrawRect(x-20,(y )+ (y/20)*2,40,1)
			surface.DrawRect(x-10,(y )+ (y/20)*3,20,1)
			surface.SetTextPos( 5, 128 ) 
			surface.SetTextColor( 255, 255, 255, 50 ) 
			surface.SetFont( "Default" )
			if self:GetOwner():GetNWString("RE2_DisplayAmmotype") == "GaussEnergy" then
				surface.DrawText("Fire Rounds "..self:GetOwner():GetAmmoCount( "GaussEnergy" ).."")
			elseif self:GetOwner():GetNWString("RE2_DisplayAmmotype") == "Battery" then
				surface.DrawText("Freeze Rounds "..self:GetOwner():GetAmmoCount( "Battery" ).."")
			elseif self:GetOwner():GetNWString("RE2_DisplayAmmotype") == "CombineCannon" then
				surface.DrawText("Explosive Rounds "..self:GetOwner():GetAmmoCount( "CombineCannon" ).."")
			end
			
	end
end


function SWEP:SetIronsights( b )
	self.Weapon:SetNetworkedBool( "Ironsights", b )
end

SWEP.NextSecondaryAttack = 0