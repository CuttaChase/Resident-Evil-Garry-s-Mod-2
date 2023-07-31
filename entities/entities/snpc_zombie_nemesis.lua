AddCSLuaFile()
ENT.Base             = "nz_base2"
ENT.Spawnable        = false
ENT.AdminSpawnable   = false
ENT.Weapon			= "re2_minigun"
--SpawnMenu--
list.Set( "NPC", "nz_boss_zombine", {
	Name = "Zombine SS",
	Class = "nz_boss_zombine",
	Category = "NextBot Zombies 2.0"
} )
ENT.stuckPos = Vector(0,0,0)
ENT.times = 1
ENT.nextCheck = 0
local delay = 1
--Stats--
ENT.FootAngles = 10
ENT.FootAngles2 = 10

ENT.MoveType = 2

ENT.CollisionHeight = 64
ENT.CollisionSide = 7

ENT.ModelScale = 1.4 

ENT.Speed = 280
ENT.WalkSpeedAnimation = 1
ENT.FlinchSpeed = 10

ENT.health = 500
ENT.Damage = 45
ENT.HitPerDoor = 5

ENT.PhysForce = 3000
ENT.AttackRange = 65
ENT.InitialAttackRange = 75
ENT.DoorAttackRange = 25

ENT.NextAttack = 1.5

--Model Settings--
ENT.Model = "models/player/re/nemesisalpha.mdl"

ENT.WalkAnim = ACT_RUN
ENT.AttackAnim = ACT_GMOD_GESTURE_RANGE_ZOMBIE 
ENT.IdleAnim = ACT_HL2MP_IDLE_CROUCH_ZOMBIE 

--Sounds--
ENT.Attack1 = Sound("npc/zombine/attack1.wav")
ENT.Attack2 = Sound("npc/zombine/attack2.wav")

ENT.DoorBreak = Sound("npc/zombie/zombie_pound_door.wav")

ENT.Enrage1 = Sound("npc/zombine/enrage1.wav")
ENT.Enrage2 = Sound("npc/zombine/enrage2.wav")

ENT.Death1 = Sound("npc/zombine/death1.wav")
ENT.Death2 = Sound("npc/zombine/death2.wav")
ENT.Death3 = Sound("npc/zombine/death3.wav")

ENT.Idle1 = Sound("npc/zombine/idle1.wav")
ENT.Idle2 = Sound("npc/zombine/idle2.wav")
ENT.Idle3 = Sound("npc/zombine/idle3.wav")
ENT.Idle4 = Sound("npc/zombine/idle4.wav")

ENT.Pain1 = Sound("npc/zombine/pain1.wav")
ENT.Pain2 = Sound("npc/zombine/pain2.wav")
ENT.Pain3 = Sound("npc/zombine/pain3.wav")

ENT.HitSound = Sound("npc/zombie/claw_strike1.wav")
ENT.Miss = Sound("npc/zombie/claw_miss1.wav")

function ENT:Precache()

--Models--
util.PrecacheModel(self.Model)
	
--Sounds--	
util.PrecacheSound(self.Attack1)
util.PrecacheSound(self.Attack2)

util.PrecacheSound(self.DoorBreak)

util.PrecacheSound(self.Enrage1)
util.PrecacheSound(self.Enrage2)

util.PrecacheSound(self.Death1)
util.PrecacheSound(self.Death2)
util.PrecacheSound(self.Death3)

util.PrecacheSound(self.Idle1)
util.PrecacheSound(self.Idle2)
util.PrecacheSound(self.Idle3)
util.PrecacheSound(self.Idle4)
	
util.PrecacheSound(self.Pain1)
util.PrecacheSound(self.Pain2)
util.PrecacheSound(self.Pain3)
	
util.PrecacheSound(self.HitSound)
util.PrecacheSound(self.Miss)

end

function ENT:Initialize()

	--Stats--
	self:SetModel(self.Model)
	self:SetModelScale( self.ModelScale, 0 )
	self:SetColor( Color( 255, 205, 205, 255 ) )
	self.LoseTargetDist	= (self.LoseTargetDist)
	self.SearchRadius 	= (self.SearchRadius)
	self:GiveWeapon()
	self.IsAttacking = false
	self.HasNoEnemy = false
	self.Throwing = false

	

	
	--Misc--
	self:Precache()
	self:CollisionSetup( self.CollisionSide, self.CollisionHeight, COLLISION_GROUP_NPC_SCRIPTED )
end

function ENT:GiveWeapon(wep)

	if SERVER  then
	local wep = ents.Create("re2_minigun")
	wep.IsNPCWeapon = true
	local pos = self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos
	wep:SetOwner(self)
	wep:SetPos(pos)
	
	wep:Spawn()
	wep.DontPickUp = true
	wep:SetSolid(SOLID_NONE)
		
	wep:SetParent(self)

	wep:Fire("setparentattachment", "anim_attachment_RH")
	wep:AddEffects(EF_BONEMERGE)

	self.Weapon = wep
	end
	
	return true


end

function ENT:ShootEnemy()

	local bullet = {}
					  bullet.Num = 1
					  bullet.Src = self.Weapon:GetPos()+Vector(0,0,0)
					  bullet.Dir = self:GetEnemy():WorldSpaceCenter()-(self.Weapon:GetPos()+Vector(0,0,-20))
					  bullet.Spread = Vector(22,22,22)
					  bullet.Tracer = 1
					  bullet.TracerName = "Tracer"
					  bullet.Force = 4
					  bullet.Damage = math.random(1,(8 + GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier))
					  bullet.AmmoType = "pistol"

self:FireBullets( bullet )

self:MuzzleFlash()

end

function ENT:ThawOut()
	if !self:IsValid() then return end
	self.Frozen = false
	self:SetPlaybackRate(self.PlaybackRate)
	self:EmitSound("physics/glass/glass_sheet_break1.wav",100,100)
	self:SetColor(Color(255,255,255,255))
	self:SetMaterial(self.Material)

	local vPoint = self:GetPos() + Vector(0,0,50)
	local effectdata = EffectData()
	effectdata:SetStart( vPoint )
	effectdata:SetOrigin( vPoint )
	effectdata:SetScale( 2 )
	util.Effect("GlassImpact", effectdata)
  self.loco:SetDesiredSpeed( math.random(30,185) )
end

function ENT:IdleFunction()

	if ( self.NextIdle or 0 ) < CurTime() then
		
		self:StartActivity( self.IdleAnim )
		self:IdleSound()
		
		self.NextIdle = CurTime() + 5	
	end
	
end

function ENT:CustomDeath( dmginfo )
	
	self:BecomeRagdoll( dmginfo )
	
	



end

function ENT:ThrowGrenade( velocity )

	local ent = ents.Create("m79_bomb")
	
	if ent:IsValid() and self:IsValid() then
		ent:SetPos(self:EyePos() + Vector(0,0,15) - ( self:GetRight() * 25 ) + ( self:GetForward() * 10 ) )
		ent:Spawn()
		ent:SetOwner( self )
				
		local phys = ent:GetPhysicsObject()
		
		if phys:IsValid() then
		
			local ang = self:EyeAngles()
			ang:RotateAroundAxis(ang:Forward(), math.Rand(-10, 10))
			ang:RotateAroundAxis(ang:Up(), math.Rand(-10, 10))
			phys:SetVelocityInstantaneous(ang:Forward() * math.Rand( velocity, velocity + 300 ))
				
		end
	end
	
end

function ENT:CustomRegen()


	
end

function ENT:CustomChaseEnemy()

	local enemy = self:GetEnemy()

	if self.Attacking then return end
		
			if enemy:IsValid() && ( self.NextThrou or 0 ) < CurTime() then
				
				self.Throwing = true
	
				timer.Simple( 2.6, function()
					if !self:IsValid() then return end
					if self:Health() < 0 then return end
					if self.Attacking then return end
					self:ShootEnemy( math.random(150, 210) )
					self:RestartGesture( ACT_GESTURE_RANGE_ATTACK_SHOTGUN )
				end)
				timer.Simple( 2.7, function()
					if !self:IsValid() then return end
					if self:Health() < 0 then return end
					if self.Attacking then return end
					self:ShootEnemy( math.random(150, 210) )
					
				end)
				timer.Simple( 2.8, function()
					if !self:IsValid() then return end
					if self:Health() < 0 then return end
					if self.Attacking then return end
					self:ShootEnemy( math.random(150, 210) )
					
				end)
				timer.Simple( 2.9, function()
					if !self:IsValid() then return end
					if self:Health() < 0 then return end
					if self.Attacking then return end
					self:ShootEnemy( math.random(150, 210) )
					
				end)
				timer.Simple( 3.0, function()
					if !self:IsValid() then return end
					if self:Health() < 0 then return end
					if self.Attacking then return end
					self:ShootEnemy( math.random(150, 210) )
					
				end)
				timer.Simple( 3.1, function()
					if !self:IsValid() then return end
					if self:Health() < 0 then return end
					if self.Attacking then return end
					self:ShootEnemy( math.random(150, 210) )
					
				end)
				timer.Simple( 3.2, function()
					if !self:IsValid() then return end
					if self:Health() < 0 then return end
					if self.Attacking then return end
					self:ShootEnemy( math.random(150, 210) )
					
				end)
				timer.Simple( 3.3, function()
					if !self:IsValid() then return end
					if self:Health() < 0 then return end
					if self.Attacking then return end
					self:ShootEnemy( math.random(150, 210) )
					
				end)
				timer.Simple( 3.4, function()
					if !self:IsValid() then return end
					if self:Health() < 0 then return end
					if self.Attacking then return end
					self:ShootEnemy( math.random(150, 210) )
					
				end)
				timer.Simple( 3.5, function()
					if !self:IsValid() then return end
					if self:Health() < 0 then return end
					if self.Attacking then return end
					self:ShootEnemy( math.random(150, 210) )
					self.Throwing = false
				end)
			
				self.NextThrou = CurTime() + 10
			end
			
	
	
end

function ENT:CustomInjure( dmginfo )
	
	if ( dmginfo:IsBulletDamage() ) then

	local attacker = dmginfo:GetAttacker()
        // hack: get hitgroup
			if attacker:IsValid() then
				local trace = {}
				trace.start = attacker:GetShootPos()
		
				trace.endpos = trace.start + ( ( dmginfo:GetDamagePosition() - trace.start ) * 2 )  
				trace.mask = MASK_SHOT
				trace.filter = attacker
		
				local tr = util.TraceLine( trace )
				hitgroup = tr.HitGroup
			end
	
		self:EmitSound("kevlar/kevlar_hit"..math.random(2)..".wav", 65)
		

	
	end


end

function ENT:FootSteps()
	self:EmitSound("npc/combine_soldier/gear"..math.random(6)..".wav", 65)
end

function ENT:AlertSound()
end

function ENT:PainSound()
	if math.random(1,10) == 1 then
		local sounds = {}
		sounds[1] = (self.Pain1)
		sounds[2] = (self.Pain2)
		sounds[3] = (self.Pain3)
		self:EmitSound( sounds[math.random(1,3)] )
	end
end

function ENT:EnrageSound()
	local sounds = {}
		sounds[1] = (self.Enrage1)
		sounds[2] = (self.Enrage2)
		self:EmitSound( sounds[math.random(1,2)] )
end

function ENT:DeathSound()
end

function ENT:AttackSound()
	local sounds = {}
		sounds[1] = (self.Attack1)
		sounds[2] = (self.Attack2)
		self:EmitSound( sounds[math.random(1,2)] )
end

function ENT:IdleSound()
	if math.random(1,10) == 1 then
		local sounds = {}
		sounds[1] = (self.Idle1)
		sounds[2] = (self.Idle2)
		sounds[3] = (self.Idle3)
		sounds[4] = (self.Idle4)
		self:EmitSound( sounds[math.random(1,4)] )
	end
end

function ENT:CustomDoorAttack( ent )

	if ( self.NextDoorAttackTimer or 0 ) < CurTime() then
		if IsValid(ent) && ent:GetPos():Distance( self:GetPos() ) < 100 then

            local dmginfo = DamageInfo()
            dmginfo:SetDamageType(DMG_SLASH)
            dmginfo:SetDamage(self:getAttackDamage())

            local force = 1
            local phys = ent:GetPhysicsObject()
            if IsValid(phys) then
                force = phys:GetVolume()/phys:GetMass() * 10
            end

            if IsValid(self:GetEnemy()) then
                local dir = (self:GetEnemy():GetPos() - self:GetPos()):Angle()
                dmginfo:SetDamageForce( dir:Forward() * self:getAttackDamage() * force + dir:Up() * force )
            else
                dmginfo:SetDamageForce( self:GetAngles():Forward() * self:getAttackDamage() * force  )
            end
            dmginfo:SetAttacker(self)

            --[[if math.random(1, 1/self:getInfectionChance()) == 1 then
                entity
            end]]--
            ent:TakeDamageInfo(dmginfo)
        end
		self:AttackSound()
		self:RestartGesture(self.AttackAnim)  
		
		self:AttackEffect( 0.9, ent, self.Damage, 2 )
	
		self.NextDoorAttackTimer = CurTime() + self.NextAttack
	end
	
end
	
function ENT:CustomPropAttack( ent )

	if ( self.NextPropAttackTimer or 0 ) < CurTime() then
	if IsValid(ent) && ent:GetPos():Distance( self:GetPos() ) < 100 then

            local dmginfo = DamageInfo()
            dmginfo:SetDamageType(DMG_SLASH)
            dmginfo:SetDamage(self:getAttackDamage())

            local force = 1
            local phys = ent:GetPhysicsObject()
            if IsValid(phys) then
                force = phys:GetVolume()/phys:GetMass() * 10
            end

            if IsValid(self:GetEnemy()) then
                local dir = (self:GetEnemy():GetPos() - self:GetPos()):Angle()
                dmginfo:SetDamageForce( dir:Forward() * self:getAttackDamage() * force + dir:Up() * force )
            else
                dmginfo:SetDamageForce( self:GetAngles():Forward() * self:getAttackDamage() * force  )
            end
            dmginfo:SetAttacker(self)

            --[[if math.random(1, 1/self:getInfectionChance()) == 1 then
                entity
            end]]--
            ent:TakeDamageInfo(dmginfo)
        end
		self:AttackSound()
		self:RestartGesture(self.AttackAnim)  
	
		self:AttackEffect( 0.9, ent, self.Damage, 1 )
	
		self.NextPropAttackTimer = CurTime() + self.NextAttack
		if ( self.loco:IsStuck() ) then
            self:HandleStuck()
            return "stuck"
        end
        coroutine.yield()
	end
	
end

function ENT:AttackEffect( time, ent, dmg, type )

	timer.Simple(time, function() 
		if !self:IsValid() then return end
		if self:Health() < 0 then return end
		if !self:CheckValid( ent ) then return end
		
		if self:GetRangeTo( ent ) < self.AttackRange then
			
			ent:TakeDamage( self.Damage, self )
			
			if ent:IsPlayer() or ent:IsNPC() then
				self:BleedVisual( 0.2, ent:GetPos() + Vector(0,0,50) )	
				self:EmitSound( self.HitSound, 90, math.random(80,90) )
				
				local moveAdd=Vector(0,0,350)
					if not ent:IsOnGround() then
						moveAdd=Vector(0,0,0)
					end
				ent:SetVelocity( moveAdd + ( ( self.Enemy:GetPos() - self:GetPos() ):GetNormal() * 150 ) )
			end
			
			if ent:IsPlayer() then
				ent:ViewPunch(Angle(math.random(-1, 1)*self.Damage, math.random(-1, 1)*self.Damage, math.random(-1, 1)*self.Damage))
			end
			
			if type == 1 then
				local phys = ent:GetPhysicsObject()
				if (phys != nil && phys != NULL && phys:IsValid() ) then
					phys:ApplyForceCenter(self:GetForward():GetNormalized()*(self.PhysForce) + Vector(0, 0, 2))
					ent:EmitSound(self.DoorBreak)
				end
			elseif type == 2 then
				if ent != NULL and ent.Hitsleft != nil then
					if ent.Hitsleft > 0 then
						ent.Hitsleft = ent.Hitsleft - self.HitPerDoor	
						ent:EmitSound(self.DoorBreak)
					end
				end
			end
							
		else	
			self:EmitSound(self.Miss)
		end
		
	end)
	
	timer.Simple( time + 0.6, function()
		if !self:IsValid() then return end
		if self:Health() < 0 then return end
		self.IsAttacking = false
	end)

end

function ENT:Attack(ent)

	if ( self.NextAttackTimer or 0 ) < CurTime() then	
	
		if ( (self.Enemy:IsValid() and self.Enemy:Health() > 0 ) ) then
		local enemy = self:GetEnemy()
		if IsValid(ent) && ent:GetPos():Distance( self:GetPos() ) < 500 && self:IsLineOfSightClear( enemy ) then
		self:EmitSound("residentevil/starsfx_re.mp3",500,100)
		end
		
		if IsValid(ent) && ent:GetPos():Distance( self:GetPos() ) < 100 then
		
            local dmginfo = DamageInfo()
            dmginfo:SetDamageType(DMG_SLASH)
            dmginfo:SetDamage(self:getAttackDamage())

            local force = 1
            local phys = ent:GetPhysicsObject()
            if IsValid(phys) then
                force = phys:GetVolume()/phys:GetMass() * 10
            end

            if IsValid(self:GetEnemy()) then
                local dir = (self:GetEnemy():GetPos() - self:GetPos()):Angle()
                dmginfo:SetDamageForce( dir:Forward() * self:getAttackDamage() * force + dir:Up() * force )
            else
                dmginfo:SetDamageForce( self:GetAngles():Forward() * self:getAttackDamage() * force  )
            end
            dmginfo:SetAttacker(self)

            --[[if math.random(1, 1/self:getInfectionChance()) == 1 then
                entity
            end]]--
            ent:TakeDamageInfo(dmginfo)
        end
			self:AttackSound()
			self.IsAttacking = true
			self:RestartGesture(self.AttackAnim)
		
			self:AttackEffect( 0.9, self.Enemy, self.Damage, 0 )
		
		end
			
		self.NextAttackTimer = CurTime() + self.NextAttack
	end	
		
end



function ENT:IsNPC()
	return true
end