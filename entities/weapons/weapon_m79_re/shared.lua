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

SWEP.Base				= "weapon_basegun_re"

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
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Delay			= 1.5
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "CombineCannon"

SWEP.Mag = 1

SWEP.Secondary.ClipSize		= 99999
SWEP.Secondary.DefaultClip	= 99999
SWEP.Secondary.Delay		= 1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"


SWEP.Item = "item_m79"

SWEP.AmmoTypeTable = { "CombineCannon","GaussEnergy","Battery"}
SWEP.AmmoNumber = 1

SWEP.Primary.Ammo			= SWEP.AmmoTypeTable[SWEP.AmmoNumber]

function SWEP:Deploy()
	self:GetOwner():SetNWString("RE2_DisplayAmmotype", self.AmmoTypeTable[self.AmmoNumber])
	self:SetIronsights( false )
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	self:GetOwner():EmitSound("weapons/m79/m79_draw.wav",100,100)
	self:Update()
	return true
end

function SWEP:CanPrimaryAttack()
	if self.Weapon.Mag <= 0 then
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
	self:GetOwner():ViewPunch(Angle( math.Rand(-0.2,-0.1) * self.Primary.Recoil,math.Rand(-0.1,0.1) *self.Primary.Recoil,0))
	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.Weapon.Mag = 0
	self:Reload()
 	if (game.SinglePlayer() && SERVER) || CLIENT then
 		self.Weapon:SetNetworkedFloat("LastShootTime",CurTime())
 	end
end

function SWEP:Reload()
	if self:GetNWBool("reloading") then return false end
	if self.Mag >= self.Primary.ClipSize then return false end
	if self.Mag < self.Primary.ClipSize && self:GetOwner():GetAmmoCount(self.Primary.Ammo) > 0  then
		self:SetIronsights( false )
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
		self:GetOwner():EmitSound("weapons/m79/m79_close.wav",100,100)
		self:SetNWBool("reloading", true)
		self:GetOwner():RestartGesture(self:GetOwner():Weapon_TranslateActivity(ACT_HL2MP_GESTURE_RELOAD))
		self:SetNextPrimaryFire(CurTime() + self.ReloadSpeed)
		self:SetNextSecondaryFire(CurTime() + self.ReloadSpeed)
		timer.Simple(self.ReloadSpeed, function()
			if self:IsValid() then
				if (self:GetOwner():GetAmmoCount(self.Primary.Ammo) + self.Weapon.Mag) >= self.Primary.ClipSize then
					if SERVER then
						self:GetOwner():RemoveAmmo(self.Primary.ClipSize - self.Weapon.Mag  ,self.Primary.Ammo )
						self.Weapon.Mag = 1
					end
				else
					if SERVER then
						self.Weapon.Mag = 1
						self:GetOwner():RemoveAmmo(self:GetOwner():GetAmmoCount(self.Primary.Ammo),self.Primary.Ammo)
					end
				end
				self:SetNWBool("reloading", false)
				self.Weapon:SetNextPrimaryFire(CurTime() + .2)
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			end
		end)
	end
end

function SWEP:Think()
	if self:GetOwner():GetAmmoCount(self.Primary.Ammo) <= 0 && self.Mag <= 0 then
		for k,v in pairs(self.AmmoTypeTable) do
			if self:GetOwner():GetAmmoCount(v) > 0 then
				self.AmmoNumber = k
				self.Primary.Ammo = self.AmmoTypeTable[self.AmmoNumber]

				self:GetOwner():SetNWString("RE2_DisplayAmmotype", self.AmmoTypeTable[self.AmmoNumber])
				if self:GetOwner():GetActiveWeapon() == self then
					self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
					self.NextSecondaryAttack = CurTime() + self.Secondary.Delay
					self:GetOwner():EmitSound("weapons/m79/m79_close.wav",50,100)
				end
				return
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
			surface.SetDrawColor(tonumber(Options["Crosshairs"]["Red"]),tonumber(Options["Crosshairs"]["Green"]),tonumber(Options["Crosshairs"]["Blue"]),255)
			surface.DrawLine(x,y ,x,y + y/5 )
			surface.DrawRect(x-40,(y ),80,1)
			surface.DrawRect(x-30,(y )+ (y/20),60,1)
			surface.DrawRect(x-20,(y )+ (y/20)*2,40,1)
			surface.DrawRect(x-10,(y )+ (y/20)*3,20,1)
	end
end
