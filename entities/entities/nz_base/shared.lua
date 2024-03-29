if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

local nb_use_ragdolls = GetGlobalBool("nb_use_ragdolls")
local nb_npc = GetConVar("nb_npc")
local ai_ignoreplayers = GetConVar("ai_ignoreplayers")
local nb_attackprop = GetConVar("nb_attackprop")
local nb_targetmethod = GetConVar("nb_targetmethod")
local nb_ignoreteam = GetConVar("nb_ignoreteam")

ENT.Base             = "base_nextbot"
ENT.Spawnable        = false
ENT.AdminOnly   = false

--Stats--
ENT.FootAngles = 5
ENT.FootAngles2 = 5

ENT.UseFootSteps = 1
ENT.MoveType = 1

ENT.Bone1 = "ValveBiped.Bip01_R_Foot"
ENT.Bone2 = "ValveBiped.Bip01_L_Foot"

ENT.SearchRadius = 2000
ENT.LoseTargetDist = 4000

ENT.Speed = 0
ENT.WalkSpeedAnimation = 0
ENT.FlinchSpeed = 0

ENT.Health = 0
ENT.Damage = 0

ENT.PhysForce = 15000
ENT.AttackRange = 60
ENT.InitialAttackRange = 90

ENT.HitPerDoor = 1
ENT.DoorAttackRange = 25

ENT.AttackWaitTime = 0
ENT.AttackFinishTime = 0

ENT.NextAttack = 1.3

ENT.FallDamage = 0

--Model Settings--
ENT.Model = ""

ENT.AttackAnim = (NONE)

ENT.WalkAnim = (NONE)

ENT.FlinchAnim = (NONE)
ENT.FallAnim = (NONE)

ENT.AttackDoorAnim = (NONE)

--Sounds--
ENT.Attack1 = Sound("")
ENT.Attack2 = Sound("")

ENT.DoorBreak = Sound("")

ENT.Death1 = Sound("")
ENT.Death2 = Sound("")
ENT.Death3 = Sound("")

ENT.Fall1 = Sound("")
ENT.Fall2 = Sound("")

ENT.Idle1 = Sound("")
ENT.Idle2 = Sound("")
ENT.Idle3 = Sound("")
ENT.Idle4 = Sound("")

ENT.Pain1 = Sound("")
ENT.Pain2 = Sound("")
ENT.Pain3 = Sound("")

ENT.Hit = Sound("")
ENT.Miss = Sound("")

function ENT:Precache()
end

function ENT:Initialize()
end

function ENT:CollisionSetup( collisionside, collisionheight, collisiongroup )
	self:SetCollisionGroup( collisiongroup )
	self:SetCollisionBounds( Vector(-collisionside,-collisionside,0), Vector(collisionside,collisionside,collisionheight) )
	self:PhysicsInitShadow(true, false)
	self.NEXTBOT = true
end

function ENT:CreateBullseye( height )
	local bullseye = ents.Create("npc_bullseye")
	bullseye:SetPos( self:GetPos() + Vector(0,0,height or 50) )
	bullseye:SetAngles( self:GetAngles() )
	bullseye:SetParent( self )
	bullseye:SetSolid( SOLID_NONE )
	bullseye:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )

	bullseye:SetOwner( self )
	bullseye:Spawn()
	bullseye:Activate()
	bullseye:SetHealth( 9999999 )

	self.Bullseye = bullseye
end

function ENT:CreateRelationShip()
	if ( self.RelationTimer or 0 ) < CurTime() then

		local bullseye = self.Bullseye

		if !self:CheckValid( bullseye ) then
			SafeRemoveEntity( bullseye )
		return end

		self.LastPos = self:GetPos( )

		local ents = ents.GetAll()
		table.Add(ents)

		for _,v in pairs(ents) do

			if v:GetClass() != self and v:GetClass() != "npc_bullseye" and v:GetClass() != "npc_grenade_frag" and v:IsNPC() then
				if nb_npc:GetInt() == 1 then
					v:AddEntityRelationship( bullseye, 1, 10 )
				else
					v:AddEntityRelationship( bullseye, 3, 10 )
				end
			end

		end

		self.RelationTimer = CurTime() + 2
	end
end

function ENT:CustomThink()
end

function ENT:SpawnFunction( ply, tr, ClassName )

	if ( !tr.Hit ) then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * 16

	if util.PointContents( tr.HitPos ) == CONTENTS_EMPTY then

	local ent = ents.Create( Class )
		ent:SetPos( SpawnPos )
		ent:Spawn()

	end

	return ent

end

function ENT:FaceTowards( ent )
	self.loco:FaceTowards( ent:GetPos() )
	self.loco:FaceTowards( ent:GetPos() )
	self.loco:FaceTowards( ent:GetPos() )
	self.loco:FaceTowards( ent:GetPos() )
	self.loco:FaceTowards( ent:GetPos() )
	self.loco:FaceTowards( ent:GetPos() )
	self.loco:FaceTowards( ent:GetPos() )

	self.loco:FaceTowards( ent:GetPos() )
	self.loco:FaceTowards( ent:GetPos() )
	self.loco:FaceTowards( ent:GetPos() )
	self.loco:FaceTowards( ent:GetPos() )
	self.loco:FaceTowards( ent:GetPos() )
	self.loco:FaceTowards( ent:GetPos() )
	self.loco:FaceTowards( ent:GetPos() )
end

function ENT:Think()
	if not SERVER then return end
	if !IsValid(self) then return end



	self:CustomThink()

	-- Step System --
	if self.UseFootSteps == 1 then
		if !self.nxtThink then self.nxtThink = 0 end
		if CurTime() < self.nxtThink then return end

		self.nxtThink = CurTime() + 0.025

	-- First Step
        local bones = self:LookupBone(self.Bone1)

        local pos, ang = self:GetBonePosition(bones)

        local tr = {}
        tr.start = pos
        tr.endpos = tr.start - ang:Right()* self.FootAngles + ang:Forward()* self.FootAngles2
        tr.filter = self
        tr = util.TraceLine(tr)

        if tr.Hit && !self.FeetOnGround then
			self:FootSteps()
        end

        self.FeetOnGround = tr.Hit

	-- Second Step
		local bones2 = self:LookupBone(self.Bone2)

        local pos2, ang2 = self:GetBonePosition(bones2)

        local tr = {}
        tr.start = pos2
        tr.endpos = tr.start - ang2:Right()* self.FootAngles + ang2:Forward()* self.FootAngles2
        tr.filter = self
        tr = util.TraceLine(tr)

        if tr.Hit && !self.FeetOnGround2 then
					self:FootSteps()
        end

        self.FeetOnGround2 = tr.Hit
	end
end

function ENT:Attack()
end

function ENT:TransformRagdoll( dmginfo )

	local ragdoll = ents.Create("prop_ragdoll")
		if ragdoll:IsValid() then 
			ragdoll:SetPos(self:GetPos())
			ragdoll:SetModel(self:GetModel())
			ragdoll:SetAngles(self:GetAngles())
			ragdoll:Spawn()
			ragdoll:SetSkin(self:GetSkin())
			ragdoll:SetColor(self:GetColor())
			ragdoll:SetMaterial(self:GetMaterial())
			
			local num = ragdoll:GetPhysicsObjectCount()-1
			local v = self.loco:GetVelocity()	
   
			for i=0, num do
				local bone = ragdoll:GetPhysicsObjectNum(i)

				if IsValid(bone) then
					local bp, ba = self:GetBonePosition(ragdoll:TranslatePhysBoneToBone(i))
					if bp and ba then
						bone:SetPos(bp)
						bone:SetAngles(ba)
					end
					bone:SetVelocity(v)
				end
	  
			end
			
			ragdoll:SetBodygroup( 1, self:GetBodygroup(1) )
			ragdoll:SetBodygroup( 2, self:GetBodygroup(2) )
			ragdoll:SetBodygroup( 3, self:GetBodygroup(3) )
			ragdoll:SetBodygroup( 4, self:GetBodygroup(4) )
			ragdoll:SetBodygroup( 5, self:GetBodygroup(5) )
			ragdoll:SetBodygroup( 6, self:GetBodygroup(6) )
			
			ragdoll:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
			
		end
	
	SafeRemoveEntity( self )

end

function ENT:MorphRagdoll( dmginfo )
	
end

function ENT:CustomDeath( dmginfo )
end

function ENT:CustomInjure( dmginfo )
end

function ENT:FootSteps()
end

function ENT:AlertSound()
end

function ENT:PainSound()
end

function ENT:DeathSound()
end

function ENT:AttackSound()
end

function ENT:IdleSound()
end

function ENT:IdleSounds()
	if self.Enemy then
		if math.random(1,3) == 1 then
			self:IdleSound()
		end
	else
		if math.random(1,18) == 1 then
			self:IdleSound()
		end
	end
end

function ENT:CheckValid( ent )
	if !ent then
		return false
	end

	if !self:IsValid() then
		return false
	end

	if self:Health() < 0 then
		return false
	end

	if !ent:IsValid() then
		return false
	end

	if ent:Health() < 0 then
		return false
	end

	return true
end

function ENT:CheckStatus()
	return true
end

function ENT:ResumeMovementFunctions()
	self:MovementFunctions( self.MoveType, self.WalkAnim, self.Speed, self.WalkSpeedAnimation )
end

function ENT:IdleFunction()
	self:MovementFunctions( 1, ACT_HL2MP_WALK_ZOMBIE_01, 0, 0 )
end

function ENT:MovementFunctions( type, act, speed, playbackrate )
	if type == 1 then
		self:StartActivity( act )
		self:SetPoseParameter("move_x", playbackrate )
	else
		self:ResetSequence( act )
		self:SetPlaybackRate( playbackrate )
		self:SetPoseParameter("move_x", playbackrate )
	end

	self.loco:SetDesiredSpeed( speed )
end

function ENT:SpawnIn()
	local nav = navmesh.GetNearestNavArea(self:GetPos())
	
	if !self:IsInWorld() or !IsValid(nav) or nav:GetClosestPointOnArea(self:GetPos()):DistToSqr(self:GetPos()) >= 100000 then 
		ErrorNoHalt("Nextbot ["..self:GetClass().."] spawned too far away from a navmesh!")
		SafeRemoveEntity(self)
	end 
	
	self:OnSpawn()
end

function ENT:OnSpawn()
	
end

function ENT:RunBehaviour()



	while ( true ) do
	if (!self.Frozen) then
	
	if self:HaveEnemy()  then
		if !self.HasNoEnemy then
		
	
		local enemy = self:GetEnemy()
	
		pos = enemy:GetPos()
		
			if ( pos ) then
			
				if enemy:Health() > 0 and enemy:IsValid() then
			
					self.HasNoEnemy = false
					if self:getRunning() then
						self.loco:SetDesiredSpeed( 5 + ( GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier * 25) )
		
					else
						self.loco:SetDesiredSpeed( 35 + ( GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier * 25) )
					end
					if self:CheckStatus() then
						self:MovementFunctions( self.MoveType, self.WalkAnim, self.Speed, self.WalkSpeedAnimation )
					end
				
					local opts = {	lookahead = 300,
						tolerance = 20,
						draw = false,
						maxage = 1,
						repath = 1	}
					self:ChaseEnemy( pos, opts )		
				
				end
			
			end
		end
		end
		
	else
	
		self.HasNoEnemy = true
		
		self:IdleFunction()
		
	end
		coroutine.yield()
	end
	return "ok"
end

function ENT:CheckRangeToEnemy()
	if ( self.CheckTimer or 0 ) < CurTime() then
	local enemy = self:GetEnemy()

	if self:GetEnemy() then

			if !enemy:IsValid() then return end
			if ( enemy:IsNPC() and enemy:Health() > 0 ) or ( enemy:IsPlayer() and enemy:Alive() ) then
				if self:GetRangeTo( enemy ) < self.InitialAttackRange then
					self:Attack()
				end
			end

	end

		self.CheckTimer = CurTime() + 1
	end
end

function ENT:ChaseEnemy( options )

	local enemy = self:GetEnemy()
	local pos = enemy:GetPos()
	
	local options = options or {}
	
	local path = Path( "Follow" )
	path:SetMinLookAheadDistance( options.lookahead or 300 )
	path:SetGoalTolerance( options.tolerance or 20 )
	path:Compute( self, pos )

	if (  !path:IsValid() ) then return "failed" end
	
	while ( path:IsValid() and self:HaveEnemy() ) do

		if ( path:GetAge() > 1 ) then	
			path:Compute( self, self:GetEnemy():GetPos() )
		end

		path:Update( self )	
		
		--path:Draw()
		
		if ( self.loco:IsStuck() ) then
			self:HandleStuck()
			return "stuck"
		end

		if enemy and enemy:IsValid() and enemy:Health() > 0 then
			if !self.IsAttacking then
				if self:GetRangeTo( enemy ) < 600 then
					if math.random( 1,500 ) == 5 then
						self:IdleSounds()
					end
				end
			end
		end

		if ai_ignoreplayers:GetInt() == 1 then
			if enemy:IsPlayer() then
				self:FindEnemy()
				self:BehaveStart()
			return end
		end

		self:CustomChaseEnemy()
		self:CheckRangeToEnemy()

		
			if enemy and enemy:IsValid() and enemy:Health() > 0 then
				if self:GetRangeTo( enemy ) < 25 or self:AttackObject() then
				elseif self:GetRangeTo( enemy ) < 25 or self:AttackDoor() then
				end
			end
		

		if ( options.maxage ) then
			if ( path:GetAge() > options.maxage ) then return "timeout" end
		end

		if ( options.repath ) then
			if ( path:GetAge() > options.repath ) then path:Compute( self, self:GetEnemy():GetPos() ) end
		end

		coroutine.yield()
	end
	return "ok"
end

function ENT:GetDoor(ent)

	local doors = {}
	doors[1] = "models/props_c17/door01_left.mdl"
	doors[2] = "models/props_c17/door02_double.mdl"
	doors[3] = "models/props_c17/door03_left.mdl"
	doors[4] = "models/props_doors/door01_dynamic.mdl"
	doors[5] = "models/props_doors/door03_slotted_left.mdl"
	doors[6] = "models/props_interiors/elevatorshaft_door01a.mdl"
	doors[7] = "models/props_interiors/elevatorshaft_door01b.mdl"
	doors[8] = "models/props_silo/silo_door01_static.mdl"
	doors[9] = "models/props_wasteland/prison_celldoor001b.mdl"
	doors[10] = "models/props_wasteland/prison_celldoor001a.mdl"

	doors[11] = "models/props_radiostation/radio_metaldoor01.mdl"
	doors[12] = "models/props_radiostation/radio_metaldoor01a.mdl"
	doors[13] = "models/props_radiostation/radio_metaldoor01b.mdl"
	doors[14] = "models/props_radiostation/radio_metaldoor01c.mdl"


	for k,v in pairs( doors ) do
		if !IsValid( ent ) then break end
		if ent:GetModel() == v and string.find(ent:GetClass(), "door") then
			return "door"
		end
	end

end

function ENT:AttackDoor()

	local door = ents.FindInSphere(self:GetPos(),25)
		if door then
			for i = 1, #door do
				local v = door[i]
					if self:GetDoor( v ) == "door" then

					if v.Hitsleft == nil then
						v.Hitsleft = 10
					end

					if v != NULL and v.Hitsleft > 0 then

						if (self:GetRangeTo(v) < (self.DoorAttackRange)) then

							if self.loco:GetVelocity( Vector( 0,0,0 ) ) then
								self:SetPoseParameter( "move_x", 0 )
							else
								self:SetPoseParameter( "move_x", self.WalkSpeedAnimation )
							end

							self:CustomDoorAttack( v )

						end

					end

					if v != NULL and v.Hitsleft < 1 then

						local door = ents.Create("prop_physics")
						if door then
						door:SetModel(v:GetModel())
						door:SetPos(v:GetPos())
						door:SetAngles(v:GetAngles())
						door:Spawn()
						door.FalseProp = true
						door:EmitSound("Wood_Plank.Break")

						local phys = door:GetPhysicsObject()
						if (phys != nil && phys != NULL && phys:IsValid()) then
						phys:ApplyForceCenter(self:GetForward():GetNormalized()*20000 + Vector(0, 0, 2))
						end

						door:SetSkin(v:GetSkin())
						door:SetColor(v:GetColor())
						door:SetMaterial(v:GetMaterial())

						SafeRemoveEntity( v )

						end

						self:BehaveStart()

					end
				end
			end
		end
end

function ENT:CustomChaseEnemy()

end

function ENT:CustomDoorAttack( ent )
end


function ENT:CustomPropAttack( ent )
end





--[[








]]--
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
  self:setRunSpeed(self.oldRun)
  self:setWalkSpeed(self.oldWalk)
end



--[[








]]--






function ENT:CheckProp( ent )
    if ent:GetCollisionGroup() == COLLISION_GROUP_DEBRIS then return false end
    if ent.dontTarget then return false end
    if ent.isCade then
        return true
    else
        return false
    end
    return false
end

function ENT:CanAttack( ent )
    if IsValid(ent) && ent:GetPos():Distance(self:GetPos()) < 65 + (65 * (self.times/2)) then
        if ent:IsPlayer() && ent:Alive()  then
            return true
        elseif self:CheckProp(ent) then
            return true
        end
    end
    return false
end


function ENT:AttackObject()
	local entstoattack = ents.FindInSphere(self:GetPos(), 25)
	for _,v in pairs(entstoattack) do

		if ( v:GetClass() == "func_breakable" || v:GetClass() == "func_physbox" || v:GetClass() == "prop_physics_multiplayer" || v:GetClass() == "prop_physics" || self:CheckProp( v ) ) then
		if v.FalseProp then return end
		if !self:CheckProp( v ) then return end

		self:CustomPropAttack( v )

			return true
		end
	end
	return false
end

function ENT:OnIgnite()
end

function ENT:OnKilled( dmginfo )

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

    local chance = math.random(1,4)
    if chance == 1 then
        sound.Play("zombie_male/zom_die.wav", self:GetPos())
    elseif chance == 2 then
        sound.Play("zombie_male/zom_die2.wav", self:GetPos())
    end

  	SetGlobalInt("RE2_DeadZombies", GetGlobalInt("RE2_DeadZombies") + 1)
  	local itemnumber = math.random(1,GAMEMODE.ZombieData[GetGlobalString("RE2_Difficulty")].ItemChance)
    local itemtype = "lol"
	if itemnumber == 1 then
        itemtype = "bherb"

	elseif (itemnumber >= 2 && itemnumber <= 4) then
		itemtype =  "spray"
	elseif (itemnumber >= 5 && itemnumber <= 10) then
		itemtype =  "pammo"
	elseif (itemnumber >= 11 && itemnumber <= 14) then
		itemtype =  "bammo"
	elseif (itemnumber >= 15 && itemnumber <= 19) then
		itemtype =  "mammo"
	elseif (itemnumber >= 20 && itemnumber <= 24) then
		itemtype =  "rammo"
	elseif (itemnumber >= 25 && itemnumber <= 27) then
		itemtype = "3ammo"
	elseif (itemnumber >= 28 && itemnumber <= 28) then
		itemtype = "tcure"
	elseif (itemnumber >= 29 && itemnumber <= 34) then
		itemtype = "gherb"
	elseif (itemnumber >= 35 && itemnumber <= 38) then
		itemtype = "rherb"
	elseif (itemnumber >= 39 && itemnumber <= 40) then
        itemtype = "bherb"
	end
	if itemtype != "lol" then
		local item = ents.Create("item_"..itemtype)
		item:SetPos(self.Entity:GetPos())
		item:Spawn()
		item:Activate( )
		timer.Simple(30, function() if item:IsValid() then item:Remove() end end)
	end
	NumZombies = NumZombies - 1

	self:BecomeRagdoll( dmginfo )
end

function ENT:DeathAnimation( anim, pos, activity, scale )
	local zombie = ents.Create( anim )
	if !self:IsValid() then return end

	if zombie:IsValid() then
		zombie:SetPos( pos )
		zombie:SetModel(self:GetModel())
		zombie:SetAngles(self:GetAngles())
		zombie:Spawn()
		zombie:SetSkin(self:GetSkin())
		zombie:SetColor(self:GetColor())
		zombie:SetMaterial(self:GetMaterial())
		zombie:SetModelScale( scale, 0 )

		zombie:StartActivity( activity )

		SafeRemoveEntity( self )
	end
end

function ENT:BleedVisual( time, pos, dmginfo )
	local bleed = ents.Create("info_particle_system")
	bleed:SetKeyValue("effect_name", "blood_impact_red_01")
	bleed:SetPos( pos )
	bleed:Spawn()
	bleed:Activate()
	bleed:Fire("Start", "", 0)
	bleed:Fire("Kill", "", time)
end

function ENT:InjureCheck( attacker1, attacker2 )
	if ai_ignoreplayers:GetInt() == 1 and attacker1 then
		return false
	end

	if ai_ignoreplayers:GetInt() == 1 and nb_npc:GetInt() == 0 and ( attacker1 or attacker2 ) then
		return false
	end



	return true
end

function ENT:OnInjured( dmginfo )

	local attacker = dmginfo:GetAttacker()
	local inflictor = dmginfo:GetInflictor()
	local player = attacker:IsPlayer()
	local npc = attacker:IsNPC()

	if self.HasNoEnemy then
		if self:IsValid() and self:Health() > 0 then
			if ( player or npc ) then
				if self:GetRangeTo( attacker ) < 1000 then
					if self:InjureCheck( player, npc ) then
						self:SetEnemy( attacker )
					end
				else
					if self:InjureCheck( player, npc ) then
						self:FaceTowards( attacker )
						self.SearchRadius = self.SearchRadius + 500
					end
				end
			end
		end
	else
		if ( self.NextEnemyHit or 0 ) < CurTime() then
			if self:IsValid() and self:Health() > 0 then
				if ( player or npc ) then

					if !self.Enemy then return end
					if !self.Enemy:IsValid() then return end
					if self.Enemy:Health() < 0 then return end
				
					if self:GetRangeTo( self.Enemy ) > 150 then
				
						if self:GetRangeTo( attacker ) > self:GetRangeTo( self.Enemy ) then
							if self:InjureCheck( player, npc ) then
								self:SetEnemy( attacker )
								self.NextEnemyHit = CurTime() + 4
							end
						end
					
					end
					
				end
			end
		end
	end

	if self.nxtPainSound then
		self:PainSound( dmginfo )
	end

	self:CustomInjure( dmginfo )


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

end

function ENT:BuddyKilled( victim, dmginfo )

	local attacker = dmginfo:GetAttacker()
	if self:GetRangeTo( attacker ) < 500 then
		self:SetEnemy( attacker )
	elseif self:GetRangeTo( victim ) < 1000 then
		self.SearchRadius = self.SearchRadius + 500
		self:FaceTowards( victim )
		self.loco:Approach( victim:GetPos(), 100)
	end

end

function ENT:OnOtherKilled( victim, dmginfo )

	if self.HasNoEnemy then
		if victim:GetClass("nazi_zombie_*", "npc_nextbot_*", "mob_zombie_*", "nz_*") and victim != self then

			if nb_npc:GetInt() == 1 then
				if dmginfo:GetAttacker():IsNPC() or dmginfo:GetAttacker():IsPlayer() then
					self:BuddyKilled( victim, dmginfo )
				end
			elseif ai_ignoreplayer:GetInt() == 1 then
				if dmginfo:GetAttacker():IsNPC() then
					self:BuddyKilled( victim, dmginfo )
				end
			else
				if dmginfo:GetAttacker():IsPlayer() then
					self:BuddyKilled( victim, dmginfo )
				end
			end

		end
	end

end

function ENT:GetEnemy()
	return self.Enemy
end

function ENT:SetEnemy( ent )

	self.Enemy = ent

	if ent != nil then
		if !ent:IsValid() then return end
		if ent:Health() < 0 then return end

		self:AlertSound()
	end

end

function ENT:CheckEnemyClass()

end

function ENT:FindEnemy()

    local target = nil
    for key, ent in pairs(ents.GetAll()) do
        if ent:IsPlayer() && GetGlobalString("Mode") != "End" then
            if (!IsValid(target) or ent:GetPos():Distance( self:GetPos() ) < target:GetPos():Distance(self:GetPos())) then
                target = ent
            end
        end
    end
    
    self:SetEnemy( target )
    return target

end

function ENT:HaveEnemy()

	local enemy = self:GetEnemy()

	if ( enemy and IsValid( enemy ) ) then
		
		if ( enemy:IsPlayer() and !enemy:Alive() ) then
			return self:FindEnemy()
		elseif ( enemy:IsNPC() and enemy:Health() < 0 ) then
			return self:FindEnemy()
	end

		return true
	else
		return self:FindEnemy()
	end
end










ENT.stuckPos = Vector(0,0,0)
ENT.times = 0
ENT.nextCheck = 0
local delay = 1
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
                  if CurTime() - self:getLastAttack() > 10 then
                      self:BecomeRagdoll( DamageInfo() )
					  --self:SetPos( self:GetPos() + Vector(math.random(-40,40),math.random(-40,40),0) )
						NumZombies = NumZombies - 1
                  else
                      if self.times > 20/modifier then
                          self:BecomeRagdoll( DamageInfo() )
						  --self:SetPos( self:GetPos() + Vector(math.random(-40,40),math.random(-40,40),0) )
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

ENT.AttackDamage = 15
function ENT:setAttackDamage(attackDamage)
    self.AttackDamage = attackDamage
end

function ENT:getAttackDamage()
    return self.AttackDamage
end

ENT.RunSpeed = 150
function ENT:setRunSpeed(RunSpeed)
    self.RunSpeed = RunSpeed
end

function ENT:getRunSpeed()
    return self.RunSpeed
end

ENT.WalkSpeed = 25
function ENT:setWalkSpeed(WalkSpeed)
    self.WalkSpeed = WalkSpeed
end

function ENT:getWalkSpeed()
    return self.WalkSpeed
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
