
if SERVER then
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= true
	SWEP.AutoSwitchFrom		= true

end
if CLIENT then
	SWEP.PrintName			= "#re2gm_wpn_knife"
	SWEP.Slot				= 0
	SWEP.SlotPos			= 0
	SWEP.DrawAmmo			= false
	SWEP.DrawCrosshair		= true
	SWEP.DrawWeaponInfoBox	= false
	SWEP.BounceWeaponIcon   = false
	SWEP.SwayScale			= 1.0
	SWEP.BobScale			= 1.0
	SWEP.IconLetter			= "j"
	--surface.CreateFont("csd",ScreenScale(60),500,true,true,"CSSelectIcons")
end
SWEP.DrawCrosshair 		= true
SWEP.ViewModelFOV	= 0
SWEP.ViewModel		= ""
SWEP.WorldModel		= ""

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Primary.Range			= 60
SWEP.Primary.Recoil			= 4.6
SWEP.Primary.Delay			= 10
SWEP.Primary.Damage			= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.NumShots		= 1

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Damage		= 1
SWEP.Secondary.Range		= 30
SWEP.Secondary.Delay		= 1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.FleshHitSounds = {
"weapons/knife/knife_hit1.wav",
"weapons/knife/knife_hit2.wav",
"weapons/knife/knife_hit3.wav",
"weapons/knife/knife_hit4.wav"
}


function SWEP:Initialize()
    if SERVER then self:SetWeaponHoldType("melee") end
end

function SWEP:Deploy()
	if SERVER then
		self:GetOwner():DrawViewModel(false)
		self:GetOwner():DrawWorldModel(false)
	end
	return true
end

function SWEP:CanPrimaryAttack()
	return true
end

function SWEP:CanSecondaryAttack()
	return true
end

function SWEP:Think()
	if self.Charging then
		self.Owner:SetVelocity(self.Owner:GetForward() * 50 + self.Owner:GetRight() * -1 + self.Owner:GetUp() * -1  )
		if SERVER then
			self.Owner:Freeze(true)
		end
	end

end

function SWEP:PrimaryAttack()

	if not self:CanPrimaryAttack() then return end
	self.Weapon:SetNextPrimaryFire(CurTime() + self.Secondary.Delay)
	local sequence = self.Weapon:LookupSequence(ACT_VM_HITCENTER)

 	local trace = util.GetPlayerTrace(self.Owner)
 	local tr = util.TraceLine(trace)
	local soundrandomizer = math.random(1,5)
	if soundrandomizer == 1 && SERVER then
		EmitSound("npc/crow/alert2.wav", self.Owner:GetPos(), 1, CHAN_AUTO, 0.3,100)
	end
	
	//self.Weapon:EmitSound("weapons/knife/knife_slash1.wav",100,math.random(90,120))

	if (self.Owner:GetPos() - tr.HitPos):Length() < self.Primary.Range then
		self.Owner:ViewPunch(Angle(math.Rand(-3,3) * self.Primary.Recoil,math.Rand(-3,3) * self.Primary.Recoil,0))
		if tr.HitNonWorld then
			if SERVER then tr.Entity:TakeDamage(self.Secondary.Damage,self.Owner) end
			if tr.Entity:IsPlayer() && tr.Entity:Team() == TEAM_HUNK then
				self:GetOwner():SetNWInt("Money",self:GetOwner():GetNWInt("Money") + 1)
			elseif tr.Entity:IsNPC() then
				self:GetOwner():SetNWInt("Money",self:GetOwner():GetNWInt("Money") + 1)
			end
			if tr.Entity:IsPlayer() or tr.Entity:IsNPC() then
				self.Weapon:EmitSound(self.FleshHitSounds[1],100,math.random(95,110))
				util.Decal("Blood",tr.HitPos + tr.HitNormal,tr.HitPos - tr.HitNormal)
				if SERVER then self:SpawnBlood(tr) end
			end
		end
	end

	--[[

	if not self:CanPrimaryAttack() then return end
	self.Charging = true
	local trace = util.GetPlayerTrace(self.Owner)
	local tr = util.TraceLine(trace)
	if tr.HitNonWorld && (self.Owner:GetPos() - tr.HitPos):Length() < self.Primary.Range then
			if SERVER then tr.Entity:TakeDamage(self.Secondary.Damage,self.Owner) end
			if tr.Entity:IsPlayer() && tr.Entity:Team() == TEAM_HUNK then
				self:GetOwner():SetNWInt("Money",self:GetOwner():GetNWInt("Money") + 1)
			elseif tr.Entity:IsNPC() then
				self:GetOwner():SetNWInt("Money",self:GetOwner():GetNWInt("Money") + 1)
			end	if tr.Entity:IsPlayer() or tr.Entity:IsNPC() then
				self.Weapon:EmitSound(self.FleshHitSounds[1],100,math.random(95,110))
				util.Decal("Blood",tr.HitPos + tr.HitNormal,tr.HitPos - tr.HitNormal)
				if SERVER then self:SpawnBlood(tr) end
			end
	end
	timer.Simple(math.random(5,10)/10,function()
		if self:IsValid() then
			self.Charging = false
			self.Owner:Freeze(false)
			local trace = util.GetPlayerTrace(self.Owner)
			local tr = util.TraceLine(trace)
			if tr.HitNonWorld && (self.Owner:GetPos() - tr.HitPos):Length() < self.Primary.Range  then
			if SERVER then tr.Entity:TakeDamage(self.Secondary.Damage,self.Owner) end
			if tr.Entity:IsPlayer() && tr.Entity:Team() == TEAM_HUNK then
				self:GetOwner():SetNWInt("Money",self:GetOwner():GetNWInt("Money") + 1)
			elseif tr.Entity:IsNPC() then
				self:GetOwner():SetNWInt("Money",self:GetOwner():GetNWInt("Money") + 1)
			end
				if tr.Entity:IsPlayer() or tr.Entity:IsNPC() then
					self.Weapon:EmitSound(self.FleshHitSounds[1],100,math.random(95,110))
					util.Decal("Blood",tr.HitPos + tr.HitNormal,tr.HitPos - tr.HitNormal)
					if SERVER then self:SpawnBlood(tr) end
				end
			end
		end
	end)
	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	]]--
end

function SWEP:SecondaryAttack()

	--[[
	if not self:CanSecondaryAttack() then return end
	self.Weapon:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
	local sequence = self.Weapon:LookupSequence(ACT_VM_HITCENTER)

 	local trace = util.GetPlayerTrace(self.Owner)
 	local tr = util.TraceLine(trace)
	local soundrandomizer = math.random(1,10)
	if soundrandomizer == 1 && CLIENT then
		EmitSound("npc/crow/alert2.wav", self.Owner:GetPos(), 1, CHAN_AUTO, 0.3,100)
	end
	
	//self.Weapon:EmitSound("weapons/knife/knife_slash1.wav",100,math.random(90,120))

	if (self.Owner:GetPos() - tr.HitPos):Length() < self.Primary.Range then
		self.Owner:ViewPunch(Angle(math.Rand(-3,3) * self.Primary.Recoil,math.Rand(-3,3) * self.Primary.Recoil,0))
		if tr.HitNonWorld then
			if SERVER then tr.Entity:TakeDamage(self.Secondary.Damage,self.Owner) end
			if tr.Entity:IsPlayer() && tr.Entity:Team() == TEAM_HUNK then
				self:GetOwner():SetNWInt("Money",self:GetOwner():GetNWInt("Money") + 1)
			elseif tr.Entity:IsNPC() then
				self:GetOwner():SetNWInt("Money",self:GetOwner():GetNWInt("Money") + 1)
			end
			if tr.Entity:IsPlayer() or tr.Entity:IsNPC() then
				self.Weapon:EmitSound(self.FleshHitSounds[1],100,math.random(95,110))
				util.Decal("Blood",tr.HitPos + tr.HitNormal,tr.HitPos - tr.HitNormal)
				if SERVER then self:SpawnBlood(tr) end
			end
		end
	end

	]]--
end
function SWEP:SpawnBlood(tr)
	local effectdata = EffectData()
	effectdata:SetOrigin(tr.HitPos)
	effectdata:SetNormal(tr.HitNormal)
	util.Effect("bodyshot", effectdata)
	util.Decal("Blood",tr.HitPos + tr.HitNormal,tr.HitPos - tr.HitNormal)
end

function SWEP:DrawWeaponSelection(x,y,wide,tall,alpha)
	draw.SimpleText(self.IconLetter,"CSSelectIcons",x + wide/2,y + tall*0.2,Color(255,210,0,255),TEXT_ALIGN_CENTER)
	draw.SimpleText(self.IconLetter,"CSSelectIcons",x + wide/2 + math.Rand(-4,4),y + tall*0.2 + math.Rand(-12,12),Color(255,210,0,math.Rand(10,80)),TEXT_ALIGN_CENTER)
	draw.SimpleText(self.IconLetter,"CSSelectIcons",x + wide/2 + math.Rand(-4,4),y + tall*0.2 + math.Rand(-9,9),Color(255,210,0,math.Rand(10,80)),TEXT_ALIGN_CENTER)
end
