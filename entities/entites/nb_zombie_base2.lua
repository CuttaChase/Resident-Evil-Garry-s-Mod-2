AddCSLuaFile()

--Convars--
local nb_targetmethod = GetConVar("nb_targetmethod")
local ai_disabled = GetConVar("ai_disabled")
local ai_ignoreplayers = GetConVar("ai_ignoreplayers")

local nb_doorinteraction = GetConVar("nb_doorinteraction")
local nb_death_animations = GetConVar("nb_death_animations")
local nb_allow_backingup = GetConVar("nb_allow_backingup")


ENT.Spawnable = false
ENT.AdminSpawnable = false

--Stats--
ENT.ChaseDistance = 2000

ENT.CollisionHeight = 64
ENT.CollisionSide = 7

ENT.HealthAmount = 50
ENT.Health = 20

ENT.Speed = 50
ENT.SprintingSpeed = 50
ENT.FlinchWalkSpeed = 25
ENT.CrouchSpeed = 40

ENT.AccelerationAmount = 200
ENT.DecelerationAmount = 900

ENT.JumpHeight = 58
ENT.StepHeight = 35
ENT.MaxDropHeight = 200

ENT.MeleeDelay = 2

ENT.ShootRange = 80
ENT.MeleeRange = 40
ENT.StopRange = 20

ENT.MeleeDamage = 5
ENT.MeleeDamageType = DMG_CLUB

ENT.MeleeDamageForce = Vector( math.random( ENT.MeleeDamage, ENT.MeleeDamage, ENT.MeleeDamage ) )

ENT.HitSound = "Flesh.ImpactHard"

--Model--
ENT.WalkAnim = ACT_HL2MP_WALK_ZOMBIE_01
ENT.FlinchWalkAnim = ACT_HL2MP_WALK_ZOMBIE_01 
ENT.CrouchAnim = ACT_HL2MP_CROUCH_ZOMBIE 
ENT.JumpAnim = ACT_HL2MP_JUMP_ZOMBIE 

ENT.MeleeAnim = ACT_GMOD_GESTURE_RANGE_ZOMBIE

ENT.ChestFlinch1 = "physflinch1"
ENT.ChestFlinch2 = "physflinch2"
ENT.ChestFlinch3 = "physflinch3"

ENT.HeadFlinch = "flinch_head"

ENT.RLegFlinch = "flinch_rightleg"
ENT.RArmFlinch = "flinch_rightarm"

ENT.LLegFlinch = "flinch_leftleg"
ENT.LArmFlinch = "flinch_leftarm"

function ENT:Initialize()

	if SERVER then
		--Make sure the model is SET before calling CollisionSetup() or else, nextbots will get stuck on eachother
		self:CustomInitialize()
		self.Health = self.Health
		self.loco:SetDeathDropHeight( self.MaxDropHeight )	
		self.loco:SetAcceleration( self.AccelerationAmount )		
		self.loco:SetDeceleration( self.DecelerationAmount )
		self.loco:SetStepHeight( self.StepHeight )
		self.loco:SetJumpHeight( self.JumpHeight )

		self:CollisionSetup( self.CollisionSide, self.CollisionHeight, COLLISION_GROUP_PLAYER )
		
		self.NEXTBOTZOMBIE = true
		self.NEXTBOT = true
		
		--Status
		self.NextCheckTimer = CurTime() + 4
		self.StuckAttempts = 0
		self.TotalTimesStuck = 0
		self.IsJumping = false
		self.IsAttacking = false
		self.FacingTowards = nil
		self.HitByVehicle = false
		self.IsAlerted = false
		self.AlertedEntity = nil
		
		self:MovementFunction()
	end
	
	if CLIENT then
		self.NEXTBOTZOMBIE = true
		self.NEXTBOT = true
	end
	
end

function ENT:CustomInitialize()

	if !self.Risen then
		self:SetModel("")
		self:SetHealth( self.HealthAmount )
	end
	
end

function ENT:CollisionSetup( collisionside, collisionheight, collisiongroup )
	self:SetCollisionGroup( collisiongroup )
	self:SetCollisionBounds( Vector(-collisionside,-collisionside,0), Vector(collisionside,collisionside,collisionheight) )
	--self:PhysicsInitShadow(true, false)
end

function ENT:CustomOnContact( ent )

	if ent:IsVehicle() then
		if self.HitByVehicle then return end
		if self:Health() < 0 then return end
		if ( math.Round(ent:GetVelocity():Length(),0) < 5 ) then return end 
		
		local veh = ent:GetPhysicsObject()
		local dmg = math.Round( (ent:GetVelocity():Length() / 5 + ( veh:GetMass() / 100 ) ), 1 )

		if dmg > self:Health() then
		
			if ent:GetOwner():IsValid() then
				self:TakeDamage( dmg, ent:GetOwner() )
			else
				self:TakeDamage( dmg, ent )
			end
		
		else
		
			self.HitByVehicle = true
			
		
		end

	end
	
	if ent != self.Enemy then
		if ( ent:IsPlayer() and !self:IsPlayerZombie( ent ) and ai_ignoreplayers:GetInt() == 0 ) or ( ent.NEXTBOT and !ent.NEXTBOTZOMBIE ) then
			if ( self.NextMeleeTimer or 0 ) < CurTime() then
				self:Melee( ent )
				self:SetEnemy( ent )
				self:BehaveStart()
				self.NextMeleeTimer = CurTime() + self.MeleeDelay
			end
		end
	end
	
	self:CustomOnContact2( ent )
	
end

function ENT:CustomOnContact2( ent )

	self:AttackProp( ent )

end

function ENT:AttackProp( ent )

	if ( ent:GetClass() == "func_breakable" || ent:GetClass() == "func_physbox" || ent:GetClass() == "prop_physics_multiplayer" || ent:GetClass() == "prop_physics" ) and !ent.FalseProp then
		if ( self.NextMeleeTimer or 0 ) < CurTime() then
			self:Melee( ent, 1 )
			self:BehaveStart()
			self.NextMeleeTimer = CurTime() + self.MeleeDelay
		end
	end

end

function ENT:MovementFunction()
	self:StartActivity( self.WalkAnim )
	self.loco:SetDesiredSpeed( self.Speed )
end

function ENT:OnSpawn()

end

function ENT:RunBehaviour()

	self:OnSpawn()
	if (!self.Frozen) then
	
	while ( true ) do

		if self:HaveEnemy() and self:CheckEnemyStatus( self.Enemy )  then
				
				pos = self:GetEnemy():GetPos()

				if ( pos ) then
					
					if self:getRunning() then
						self.loco:SetDesiredSpeed( self:getRunSpeed() )
		
					else
						self.loco:SetDesiredSpeed( self:getWalkSpeed() )
					end
					
					self:MovementFunction()
						
					local enemy = self:GetEnemy()
					local maxageScaled=math.Clamp(pos:Distance(self:GetPos())/1000,0.1,3)	
					local opts = {	lookahead = 30,
							tolerance = 20,
							draw = false,
							maxage = maxageScaled 
							}
						
					self:ChaseEnemy( opts )
						
				end

					
		else
				
			coroutine.wait( 1 )	
			self:MovementFunction()
					
		end
			
		self:PlayIdleSound()
			
		coroutine.yield()
			
	end
	
	end
	
end

function ENT:BehaveUpdate( fInterval )

	if ( !self.BehaveThread ) then return end
		
		self:CustomBehaveUpdate()
		
	local ok, message = coroutine.resume( self.BehaveThread )
	if ( ok == false ) then

		self.BehaveThread = nil
		Msg( self, "error: ", message, "\n" );

	end

end

function ENT:CustomBehaveUpdate()

	if self:HaveEnemy() and self:CheckEnemyStatus( self.Enemy ) then
		
		if ( self:GetRangeSquaredTo( self.Enemy ) < (self.ShootRange*self.ShootRange) and self:IsLineOfSightClear( self.Enemy ) ) then

			if ( self.NextMeleeAttackTimer or 0 ) < CurTime() then
				self:Melee( self.Enemy )
				self.NextMeleeAttackTimer = CurTime() + self.MeleeDelay
			end

		end
			
		if self.IsAttacking then
			if self.FacingTowards:IsValid() and self.FacingTowards:Health() > 0 then
				self.loco:FaceTowards( self.FacingTowards:GetPos() )
			end
		end
			
	end
	
end

function ENT:Melee( ent, type, time )

	if self.IsAttacking then return end
	if self.Flinching then return end

	self.IsAttacking = true 
	self.FacingTowards = ent
	
	self:RestartGesture( self.MeleeAnim )
	self:PlayAttackSound()
	
	timer.Simple( time or 0.9, function()
		if ( IsValid(self) and self:Health() > 0 ) and IsValid(ent) then
		
			if self.Flinching then return end
			
			local misssound = table.Random( self.MissSounds )
			self:EmitSound( Sound( misssound ), 90, self.MissSoundPitch or 100 )
			
			if self:GetRangeSquaredTo( ent ) > (self.MeleeRange*self.MeleeRange) then return end
		
			self:DoDamage( self.MeleeDamage, self.MeleeDamageType, ent )
			
			if type == nil then
				local hitsound = table.Random( self.HitSounds )
				ent:EmitSound( Sound( hitsound ), 90, self.HitSoundPitch or 100 )
			else
				ent:EmitSound( self.PropHitSound )
			end
	
			if type == 1 then --Prop
				local phys = ent:GetPhysicsObject()
				if (phys != nil && phys != NULL && phys:IsValid() ) then
					phys:ApplyForceCenter(self:GetForward():GetNormalized()*( ( self.MeleeDamage * 1000 ) ) + Vector(0, 0, 2))
				end
			elseif type == 2 then --Door
				ent.Hitsleft = ent.Hitsleft - 1
			end
	
		end
	end)
	
	if time then
		timer.Simple( time + 0.4, function()
			if ( IsValid(self) and self:Health() > 0) then
				self.IsAttacking = false
			end
		end)
	else
		timer.Simple( 1.3, function()
			if ( IsValid(self) and self:Health() > 0) then
				self.IsAttacking = false
			end
		end)
	end
	
end

function ENT:GetEnemy()
	return self.Enemy
end

function ENT:SetEnemy( ent )
	
	self.Enemy = ent
	
	
		if ent and ent:IsValid() and ent:Health() > 0 then
			self:PlayAlertSound()
			self:AlertNearby()
		end
	
end

function ENT:SearchForEnemy( ents )
	

	
end

function ENT:FindEnemy()

	local pos = self:GetPos()

	local min_dist, closest_target = -1, nil

	for _, target in pairs(player.GetAll()) do
		if (IsValid(target)&&target:Alive()&&target:Team() != TEAM_SPECTATOR&&GetGlobalString("Mode") != "End"&&target:GetMoveType() == MOVETYPE_WALK) then
			local dist = target:NearestPoint(pos):Distance(pos)
			if ((dist < min_dist||min_dist==-1)) then
				closest_target = target
				min_dist = dist
				self:SetEnemy( target )
			end
		end
	end
	
		for key, ent in pairs(ents.FindInSphere(self:GetPos(), 35)) do
			if (IsValid(ent) && self:CheckProp(ent)) then
				self:Melee(ent)
			end
		end

	return closest_target
	
end

function ENT:HaveEnemy()

	local enemy = self:GetEnemy()

	if ( enemy and IsValid( enemy ) and GetGlobalString("Mode") != "End" ) then
		if ( enemy:Health() < 0 ) then
			return self:FindEnemy()
		end
		
		if enemy:IsPlayer() then
			return self:FindEnemy()
		end
		
		if ( self.NextCheckTimer or 0 ) < CurTime() then --Every 4 seconds, find new and best target
			self:FindEnemy()
			self.NextCheckTimer = CurTime() + 4
		end
		
		return true
		
	else
		return self:FindEnemy()
	end
end

function ENT:BodyUpdate()

	--if !self.IsAttacking then

		if ( self:GetActivity() == self.WalkAnim ) then

			self:BodyMoveXY()

		elseif ( self:GetActivity() == self.SprintingAnim ) then
		
			self:BodyMoveXY()
		
		end

	--else
	
		--if self.loco:GetVelocity():Length() < 0.5 then
			--self:SetPoseParameter("move_x", 0.2 )
		--else
			--self:SetPoseParameter("move_x", 0.8 )
		--end
	
	--end
	
	--self:FrameAdvance()

end

function ENT:AttackDoor( ent )

	if ( self.NextMeleeTimer or 0 ) < CurTime() then
		self:Melee( ent, 2 )
		self.NextMeleeTimer = CurTime() + self.MeleeDelay
	end
	
end

function ENT:ContactDoor( ent )

	if ent.Hitsleft == nil then
		ent.Hitsleft = 10
	end

	if ent != NULL and ent.Hitsleft > 0 then

		self:AttackDoor( ent )

	end

	if ent != NULL and ent.Hitsleft < 1 then

		local door = ents.Create("prop_physics")
			if door then
				door:SetModel(ent:GetModel())
				door:SetPos(ent:GetPos())
				door:SetAngles(ent:GetAngles())
				door:Spawn()
				door.FalseProp = true
				door:EmitSound("Wood_Plank.Break")

		local phys = door:GetPhysicsObject()
			if (phys != nil && phys != NULL && phys:IsValid()) then
				phys:ApplyForceCenter(self:GetForward():GetNormalized()*20000 + Vector(0, 0, 2))
			end

				door:SetSkin(ent:GetSkin())
				door:SetColor(ent:GetColor())
				door:SetMaterial(ent:GetMaterial())

		SafeRemoveEntity( ent )

	end

	end
					
end

function ENT:CheckPathAge( path )

	if path then
	
		local length = path:GetLength()
		local age = 2

		if length < 1000 then
			age = 0.8
		elseif length < 500 then
			age = 0.5
		elseif length < 200 then
			age = 0.2
		end
		
		return age
	
	else
	
		return 1
	
	end

end

function ENT:CheckProp( ent )
    if ent:GetCollisionGroup() == COLLISION_GROUP_DEBRIS then return false end
    if ent.dontTarget then return false end
    if ent.isCade then
        return true
    else
        local phys = ent:GetPhysicsObject()
        if IsValid(phys) then
            if phys:GetVolume() > 300 && phys:IsMotionEnabled() then
                return true
            end
        end
    end
    return false
end

function ENT:ChaseEnemy( options )

	local enemy = self:GetEnemy()
	local pos = enemy:GetPos()
	
	local options = options or {}
	
	local path = Path( "Follow" )
	path:SetMinLookAheadDistance( options.lookahead or 30 )
	path:SetGoalTolerance( options.tolerance or 20 )
	path:Compute( self, pos )

	if (!path:IsValid() ) then return "failed" end
	
	if !enemy then return "failed" end
	
	if !enemy:IsValid() then return "failed" end
	
	if enemy:Health() < 0 then return "failed" end
	
	if self:IsPlayerZombie( enemy ) then return "failed" end
	
	while ( path:IsValid() and self:HaveEnemy() and ( enemy:IsValid() and enemy:Health() > 0) ) do

		
		
		for key, ent in pairs(ents.FindInSphere(self:GetPos(), 35)) do
			if IsValid(ent) then
				if ent:IsPlayer() && self:GetRangeTo( ent ) < self.MeleeRange then
				self:Melee(ent)
				end
			end
		end
	
		if nb_doorinteraction:GetInt() == 1 then
			if !self:CheckDoor() then
			
			elseif ( self:CheckDoor():IsValid() and self:GetRangeSquaredTo( self:CheckDoor() ) < self.StopRange*self.StopRange and self:Visible( self:CheckDoor() ) ) then
				self:ContactDoor( self:CheckDoor() )
				return "ok"
			end
		end
	
		if ( !self.Reloading and !self.loco:IsStuck() and ( enemy and enemy:IsValid() and enemy:Health() > 0) ) then
			if ( path:GetAge() > options.maxage ) then	
			--if ( path:GetAge() > ( self:CheckPathAge( path ) ) ) then
				path:Compute( self, enemy:GetPos() )
			end
			
		end
		
		path:Update( self )	
		
		if ( options.draw ) then
			path:Draw()
		end
		
		if ( self.loco:IsStuck() ) then
			self:HandleStuck( 0 )
			return "stuck"
		end
		
		coroutine.yield()
	end
	
	return "ok"
end

function ENT:OnLandOnGround()

	self.IsJumping = false
	
	self:MovementFunction()
	
end

function ENT:OnNavAreaChanged( old, new )

	if old:HasAttributes( 1 ) then
		if !self.Reloading then
			self:MovementFunction( "crouching" )
		else
			
		end
		self.Crouching = true
	else
		if !self.Reloading then
			self:MovementFunction()
		end
		self.Crouching = false
	end
		
end

function ENT:Think()

	if self.IsAlerted then
	
		if self.AlertedEntity and ( IsValid( self.AlertedEntity ) and self.AlertedEntity:Health() > 0 ) then
			self.loco:FaceTowards( self.AlertedEntity:GetPos() )
		end
	
	end

end

function ENT:OnOtherKilled( ent, dmginfo )

	if nb_targetmethod:GetInt() == 1 then

		if ( self.NextKilledEnemyTimer or 0 ) < CurTime() then
	
			if ent then
			
				if ( ent.NEXTBOT or ( ent:IsPlayer() and !self:IsPlayerZombie( ent ) and ai_ignoreplayers:GetInt() == 0 ) ) then
				
					if !self:HaveEnemy() then
				
						local enemy = dmginfo:GetAttacker()
			
						if enemy and ( IsValid( enemy ) and enemy:Health() > 0 ) then
					
							if ( enemy.NEXTBOT and !enemy.NEXTBOTZOMBIE ) or ( ent:IsPlayer() and !self:IsPlayerZombie( ent ) and ai_ignoreplayers:GetInt() == 0 ) then
					
								if ( ( self:GetRangeSquaredTo( enemy ) < ( self.ChaseDistance*self.ChaseDistance ) or 1000*1000 ) and self:IsLineOfSightClear( enemy ) ) then
							
									self:SetEnemy( enemy )
									self:BehaveStart()
							
								else
								
									self:CheckAlert( ent )
								
								end
					
							end
							
						end	
				
					end
				
				end
			
			end
	
			self.NextKilledEnemyTimer = CurTime() + 1
		end
	
	end
	
	self:CustomOnOtherKilled( ent, dmginfo )

end

function ENT:CustomOnOtherKilled( ent, dmginfo )

end

function ENT:CheckAlert( ent )

	if ent and ( IsValid( ent ) and ent:Health() > 0 ) then
		
		local orgrate = self.loco:GetMaxYawRate()
		self.loco:SetMaxYawRate( 10 )
		
		self.IsAlerted = true
		self.AlertedEntity = ent
			
		timer.Simple( 1.5, function()
			if IsValid( self ) and self:Health() > 0 then
				
				self.loco:SetMaxYawRate( orgrate )
				self.IsAlerted = false
					
			end
		end)
			
	end

end

function ENT:AlertNearby( ent )

	if ent and ( IsValid( ent ) and ent:Health() > 0 ) then

		for k,v in pairs( ents.FindByClass("nb_*") ) do

			if v.NEXTBOTZOMBIE then

				if !v:HaveEnemy() then
					
					if self:GetRangeSquaredTo( v ) < 250*250 and self:IsLineOfSightClear( v ) then
					
						if ( IsValid( v ) and v:Health() > 0 ) then
						
							v:SetEnemy( ent )
							v:BehaveStart()

						end
						
					end

				end

			end
			
		end

	end
	
end

function ENT:CheckEnemyPosition( dmginfo )



		if ( self.NextEnemyCheckTimer or 0 ) < CurTime() then

			local enemy = dmginfo:GetAttacker()

			if enemy and ( IsValid( enemy ) and enemy:Health() > 0 ) then
			
				if enemy:IsPlayer() then
			
					if !self:HaveEnemy() then
					
						if ( ( self:GetRangeSquaredTo( enemy ) < (self.ChaseDistance*self.ChaseDistance) or ( 2000*2000 ) ) and self:IsLineOfSightClear( enemy ) ) then
							
							self:SetEnemy( enemy )
							self:BehaveStart()
								
							self:AlertNearby( enemy )
								
						else
							
							self:CheckAlert( enemy )
								
						end
					
					end

				end
				
			end	
				
			self.NextEnemyCheckTimer = CurTime() + 1
		end

	
end

function ENT:OnInjured( dmginfo )

	--1=Zombie,2=Rebel,3=Mercenary,4=Combine
	

	if ( dmginfo:IsBulletDamage() ) then

		local attacker = dmginfo:GetAttacker()
	
			local trace = {}
			trace.start = attacker:EyePos()

			trace.endpos = trace.start + ( ( dmginfo:GetDamagePosition() - trace.start ) * 2 )  
			trace.mask = MASK_SHOT
			trace.filter = attacker
		
			local tr = util.TraceLine( trace )
			hitgroup = tr.HitGroup
			
			if hitgroup == ( HITGROUP_LEFTLEG or HITGROUP_RIGHTLEG ) then
				dmginfo:ScaleDamage(0.45)	
			end

			if hitgroup == HITGROUP_HEAD then
				dmginfo:ScaleDamage( self.HeadShotMultipler or 8 )
				self:EmitSound("hits/headshot_"..math.random(9)..".wav", 70)
			end
			
	end
	
	local dmg = dmginfo
  if dmg:IsExplosionDamage() then
		dmg:SetDamage(dmg:GetDamage() * 2)
		if dmg:GetAttacker():GetClass() == "env_explosion" && dmg:GetAttacker().Owner != nil then
			dmg:SetAttacker(dmg:GetAttacker().Owner)
			if dmg:GetInflictor().Class == "Ice" && !self.Frozen then
				self.Frozen = true
				self.oldRun = self:getRunSpeed()
				self.oldWalk = self:getWalkSpeed()
				self:setRunSpeed(1)
				self:setWalkSpeed(1)
				self.PlaybackRate = self:GetPlaybackRate()
				self:SetPlaybackRate(0)
				dmg:SetDamage(dmg:GetDamage()/16)

        self.Material = self:GetMaterial()
      	self.Entity:SetMaterial("models/shiny")
      	self.Entity:SetColor(Color(230,230,255,255))

				if self.Flame != nil then
					if self.Flame:IsValid() then
						self.Flame:Remove()
					end
				end
				timer.Simple(math.random(10,50)/10,function()	if !self:IsValid() then return end  self:ThawOut() end)
			elseif dmg:GetInflictor().Class == "Flame" then
				dmg:SetDamage(dmg:GetDamage()*1.5)
				self.Flame = ents.Create("env_Fire")
				self.Flame:SetKeyValue("Health",math.random(50,150)/10)
				self.Flame:SetKeyValue("FireSize",math.random(40,60))
				self.Flame:SetPos(self:GetPos() + self:GetForward() * 5)
				self.Flame:SetParent(self)
				self.Flame:Spawn()
				self.Flame:Fire("StartFire")
			end
		end
	end
	
	self:Flinch( dmginfo, hitgroup )
	
	self:PlayPainSound()
	
	self:CheckEnemyPosition( dmginfo )
	
end

function ENT:PlayFlinchSequence( string, rate, cycle, speed, time )
	self.Flinching = true

	self:ResetSequence( string )
	self:SetCycle( cycle )
	self:SetPlaybackRate( rate )
	self.loco:SetDesiredSpeed( speed )
	
	timer.Simple(time, function() 
		if ( self:IsValid() and self:Health() > 0 ) then
			self:MovementFunction()
			self:BehaveStart()
			self.Flinching = false
		end
	end)
end

function ENT:HardFlinch( dmginfo, hitgroup )
	
	if ( self.NextFlinchTimer or 0 ) < CurTime() then
	
		if hitgroup == HITGROUP_HEAD then
			self:PlayFlinchSequence( self.HeadFlinch, 1, 0, 0, 0.7 )
		elseif hitgroup == HITGROUP_LEFTLEG then
			self:PlayFlinchSequence( self.LLegFlinch, 1, 0, 0, 2.5 )
		elseif hitgroup == HITGROUP_RIGHTLEG then
			self:PlayFlinchSequence( self.RLegFlinch, 1, 0, 0, 1.6 )
		elseif hitgroup == HITGROUP_LEFTARM then
			self:PlayFlinchSequence( self.LArmFlinch, 1, 0, 0, 0.7 )
		elseif hitgroup == HITGROUP_RIGHTARM then
			self:PlayFlinchSequence( self.RArmFlinch, 1, 0, 0, 0.7 )
		elseif hitgroup == HITGROUP_CHEST or HITGROUP_GEAR or HITGROUP_STOMACH then
			if math.random(1,3) == 1 then
				self:PlayFlinchSequence( self.ChestFlinch1, 1, 0, 0, 0.5 )
			elseif math.random(1,3) == 2 then
				self:PlayFlinchSequence( self.ChestFlinch2, 1, 0, 0, 0.6 )
			elseif math.random(1,3) == 3 then
				self:PlayFlinchSequence( self.ChestFlinch3, 1, 0, 0, 0.6 )
			end
		end
		
		self.NextFlinchTimer = CurTime() + 2	
	end	
	
end

function ENT:Flinch( dmginfo, hitgroup )
	
	if ( self.NextFlinchTimer or 0 ) < CurTime() then
		
		
		
		self.loco:SetDesiredSpeed( self.Speed / 2 )
		
		timer.Simple( 0.14, function()
			if ( IsValid(self) and self:Health() > 0) then
				self.loco:SetDesiredSpeed(self.Speed)
			end
		end)
		
		self.NextFlinchTimer = CurTime() + 0.15
	end
	
end

function ENT:OnKilled( dmginfo )

	if self.HitByVehicle then 
	return end

	if dmginfo:IsExplosionDamage() then
		self:BecomeRagdoll( dmginfo )
	else
		if dmginfo:GetDamage() > 50 then
			self:BecomeRagdoll( dmginfo )
		else
			
				self:BecomeRagdoll( dmginfo )
		end
	end
	
	local killer = dmginfo:GetAttacker()
  	if killer:IsPlayer() then
  		local old = killer:GetNWInt("killcount")
  		killer:SetNWInt("killcount", old + 1)
  		local oldm = killer:GetNWInt("Money")
  		killer:SetNWInt("Money", oldm + 1 * GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier )

  	end
	if(IsValid(dmginfo:GetAttacker()) && dmginfo:GetAttacker():IsPlayer()) then
		dmginfo:GetAttacker():AddFrags(1)
		hook.Call( "OnNPCKilled", GAMEMODE, self, dmginfo:GetAttacker(), dmginfo:GetInflictor() )
	end
  	if self.Flame != nil then
  		if self.Flame:IsValid() then
  			self.Flame:Remove()
  		end
  	end
	
  	SetGlobalInt("RE2_DeadZombies", GetGlobalInt("RE2_DeadZombies") + 1)
  	local itemnumber = math.random(1,GAMEMODE.ZombieData[GetGlobalString("RE2_Difficulty")].ItemChance)
  	if itemnumber <= 30 then
  		local itemtype = GAMEMODE:str_SelectRandomItem()
  		local item = ents.Create("item_base")
  		item:SetNWString("Class", itemtype)
  		item:SetPos(self.Entity:GetPos() + Vector(0,0,30) )
  		item:Spawn()
  		item:Activate()
  		item:GetPhysicsObject()
  		timer.Simple(60, function() if item:IsValid() then item:Remove() end end)
  	end
	self:BecomeRagdoll( dmginfo )
	NumZombies = NumZombies - 1
	
	self:PlayDeathSound()
	
end

function ENT:PlayAttackSound()
	if self:Health() < 0 then return end

	if ( self.NextAttackSoundTimer or 0 ) < CurTime() then
	
		local randomsound = table.Random( self.AttackSounds )
		self:EmitSound( Sound( randomsound ), 100, self.AttackSoundPitch or 100, 1, CHAN_VOICE )
		
		self.NextAttackSoundTimer = CurTime() + self.MeleeDelay
	end
end

function ENT:PlayPainSound()
	if self:Health() < 0 then return end

	if ( self.NextPainSoundTimer or 0 ) < CurTime() then
	
		local randomsound = table.Random( self.PainSounds )
		self:EmitSound( Sound( randomsound ), 100, self.PainSoundPitch or 100, 1, CHAN_VOICE )
	
		self.NextPainSoundTimer = CurTime() + math.random(1,4)
	end
end

function ENT:PlayAlertSound()
	if self:Health() < 0 then return end

	if ( self.NextAlertSoundTimer or 0 ) < CurTime() then
	
		local randomsound = table.Random( self.AlertSounds )
		self:EmitSound( Sound( randomsound ), 100, self.AlertSoundPitch or 100, 1, CHAN_VOICE )
	
		self.NextAlertSoundTimer = CurTime() + math.random(16,36)
	end
end

function ENT:PlayDeathSound()
	if ( self.NextDeathSoundTimer or 0 ) < CurTime() then
	
		local randomsound = table.Random( self.DeathSounds )
		self:EmitSound( Sound( randomsound ), 100, self.DeathSoundPitch or 100, 1, CHAN_VOICE )
	
		self.NextDeathSoundTimer = CurTime() + 1
	end
end

function ENT:PlayIdleSound()
	if self:Health() < 0 or self.IsAttacking or self.Flinching then return end
	
	if ( self.NextIdleSoundTimer or 0 ) < CurTime() then
	
		local randomsound = table.Random( self.IdleSounds )
		self:EmitSound( Sound( randomsound ), 100, self.IdleSoundPitch or 100, 1, CHAN_VOICE )
	
		self.NextIdleSoundTimer = CurTime() + math.random(16,36)
	end
end











-------------------------------------------------

ENT.stuckPos = Vector(0,0,0)
ENT.times = 0
ENT.nextCheck = 0
local delay = 1



----------------------------------------------------
function ENT:setAttackAnims(newAttackAnims)
    self.AttackAnims = newAttackAnims
end

function ENT:getAttackAnims()
    return self.AttackAnims
end

ENT.InfectionChance = .15
function ENT:setInfectionChance(newInfectionChance)
    self.InfectionChance = newInfectionChance
end

function ENT:getInfectionChance()
    return self.InfectionChance
end

ENT.AttackSpeed = 3
function ENT:setAttackSpeed(attackSpeed)
    self.AttackSpeed = attackSpeed
end

function ENT:getAttackSpeed()
    return self.AttackSpeed
end

function ENT:setAttackDamage(attackDamage)
    self.MeleeDamage = attackDamage
end

function ENT:getAttackDamage()
    return self.AttackDamage
end

function ENT:setRunSpeed(RunSpeed)
    self.SprintingSpeed = RunSpeed
end

function ENT:getRunSpeed()
    return self.SprintingSpeed
end

function ENT:setWalkSpeed(WalkSpeed)
    self.Speed = WalkSpeed
end

function ENT:getWalkSpeed()
    return self.Speed
end

ENT.Running = false
function ENT:setRunning(newBool)
    self.Running = tobool(newBool)
end

function ENT:getRunning()
    return self.Running
end

ENT.LastAttack = 0
function ENT:setLastAttack(newLastAttack)
    self.LastAttack = newLastAttack
end

function ENT:getLastAttack()
    return self.LastAttack
end











----------------

function ENT:BehaveUpdate( fInterval )

    if ( !self.BehaveThread ) then return end

    -- -- If you are not jumping yet and a player is close jump at them
    -- local ent = ents.FindInSphere( self:GetPos(), 30 )
    -- for k,v in pairs( ent ) do
    --     if v:IsPlayer() then
    --         self:SetSequence( "attackC" )
    --     end
    -- end
    if (!self.Frozen) then
      local modifier = 1
      if self:getRunning() then modifier = 2 end
      if self.nextCheck < CurTime() then
          if self.stuckPos:Distance(self:GetPos()) < 5 then
              self.times = self.times + 1
              if self.times > 10/modifier then
                  if CurTime() - self:getLastAttack() > 5 then
                      self:BecomeRagdoll( DamageInfo() )
					  NumZombies = NumZombies - 1
                  else
                      if self.times > 20/modifier then
                          self:BecomeRagdoll( DamageInfo() )
						  NumZombies = NumZombies - 1
                      end
                  end
              end
          else
              self.stuckPos = self:GetPos()
              self.times = 0
          end
          self.nextCheck = CurTime() + delay
      end

      local ok, message = coroutine.resume( self.BehaveThread )
      if ( ok == false ) then

          self.BehaveThread = nil
          Msg( self, "error: ", message, "\n" );

      end
    end
end



local gibmods = {
    {Model = "models/props_junk/watermelon01_chunk02a.mdl", Material = "models/flesh"},
    {Model = "models/props_junk/watermelon01_chunk01a.mdl", Material = "models/flesh"},
    {Model = "models/props/cs_italy/orangegib1.mdl", Material = "models/flesh"},
    {Model = "models/props/cs_italy/orangegib2.mdl", Material = "models/flesh"},
    {Model = "models/gibs/hgibs.mdl", Material = "models/flesh"},
    -- {Model = "models/Gibs/HGIBS_rib.mdl", },
    -- {Model = "models/Gibs/HGIBS_scapula.mdl", },
    -- {Model = "models/Gibs/HGIBS_spine.mdl", },
}

function ENT:ThawOut()
	if !self:IsValid() then return end
	self.Frozen = false
	self:SetPlaybackRate(1)
	self:EmitSound("physics/glass/glass_sheet_break1.wav",100,100)
	self:SetColor(Color(255,255,255,255))
	self:SetMaterial(self.Material)

	local vPoint = self:GetPos() + Vector(0,0,50)
	local effectdata = EffectData()
	effectdata:SetStart( vPoint )
	effectdata:SetOrigin( vPoint )
	effectdata:SetScale( 2 )
	util.Effect("GlassImpact", effectdata)
	self:setRunSpeed(self.oldRun)
	self:setWalkSpeed(self.oldWalk)
	self.loco:SetDesiredSpeed(self:getWalkSpeed())
	self.loco:SetDesiredSpeed(self:getWalkSpeed())
end



----------------------------------------------

