if (CLIENT) then
	SWEP.DrawAmmo			= true
	SWEP.DrawCrosshair		= false
	SWEP.ViewModelFOV	= 50
	SWEP.ViewModelFlip		= false
	SWEP.CSMuzzleFlashes	= false
	SWEP.PrintName			= "C4 Plastic Explosives Detonater"			
	SWEP.Author				= "Noobulator"
	SWEP.Slot				= 0
	SWEP.SlotPos			= 2
end
SWEP.Author			= "Noobulator"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_c4.mdl"
SWEP.WorldModel			= "models/weapons/w_c4.mdl"

SWEP.Primary.Recoil			= 0
SWEP.Primary.Damage			= -1
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0
SWEP.Primary.Delay			= 1.0
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.Recoil		= 0
SWEP.Secondary.Damage		= -1
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.Cone			= 0
SWEP.Secondary.Delay		= 0.5
SWEP.Secondary.NextFire 	= 0

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"
SWEP.HoldType = "knife"

function SWEP:Initialize()
	if (SERVER) then
		self:SetWeaponHoldType(self.HoldType)
	end
end

function SWEP:Deploy()
end

function SWEP:Reload()
end

function SWEP:Think()
end
	
function SWEP:PrimaryAttack()
	if SERVER then
		for k,v in pairs (ents.FindByClass("item_c4")) do
			if v.Owner == self:GetOwner() then
				v:Asplode()
				self:SetNextPrimaryFire(CurTime() + 0.2)
			end
		end
	end
end


function SWEP:SecondaryAttack()

end

function SWEP:Holster()
	return true
end

function SWEP:OnRemove()
	return true
end


