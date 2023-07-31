AddCSLuaFile()

ENT.Base             = "base_nextbot"
ENT.Spawnable        = true
ENT.BaseDamage 		= math.random(3,10)
ENT.Owner 			= nil
ENT.SearchRadius = 100
ENT.LoseTargetDist = 200
ENT.stuckPos = Vector(0,0,0)
ENT.times = 0
ENT.nextCheck = 0
local delay = 1

local idl = {
	"zombie_male/zom_idle.wav",
	"zombie_male/zom_idle2.wav",
	"zombie_male/zom_idle3.wav",
}


function ENT:Initialize()
    if self:GetModel() == nil or self:GetModel() == "models/error.mdl" then
        self:SetModel(table.Random({
            "models/nmr_zombie/berny.mdl",
            "models/nmr_zombie/casual_02.mdl",
            "models/nmr_zombie/herby.mdl",
            "models/nmr_zombie/jogger.mdl",
            "models/nmr_zombie/julie.mdl",
            "models/nmr_zombie/toby.mdl",
        }))
    end
    self:EmitSound(table.Random(idl),75,75)
    --self:SetColor( Color( 255, 0, 0, 50 ) ) 
    self.SearchRadius = 50
	self.LoseTargetDist = 100

    self.Entity:SetCollisionBounds( Vector(-8,-8,0), Vector(8,8,67) )
    self:SetCollisionGroup(COLLISION_GROUP_NPC_SCRIPTED)

end


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
                      SafeRemoveEntity( self )
                      NumZombies = NumZombies - 1
                  else
                      if self.times > 20/modifier then
                          SafeRemoveEntity( self )
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

function ENT:OnLandOnGround()
    if self:getRunning() then
        self:StartActivity( ACT_RUN )
    else
        self:StartActivity( ACT_WALK )
    end
end

function ENT:Use( activator, caller, type, value )

end


ENT.FootAngles = 5
ENT.FootAngles2 = 5

ENT.UseFootSteps = 1
ENT.MoveType = 1

ENT.Bone1 = "ValveBiped.Bip01_R_Foot"
ENT.Bone2 = "ValveBiped.Bip01_L_Foot"
function ENT:Think()
    if not SERVER then return end
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

function ENT:FootSteps()
	self:EmitSound("npc/zombie/foot"..math.random(3)..".wav", 70)
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
  self:setRunSpeed(self.oldRun)
  self:setWalkSpeed(self.oldWalk)
end

function ENT:OnInjured(dmginfo)
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
		itemtype = "pammo"
	elseif (itemnumber >= 29 && itemnumber <= 34) then
		itemtype = "gherb"
	elseif (itemnumber >= 35 && itemnumber <= 38) then
		itemtype = "rherb"
	elseif (itemnumber >= 39 && itemnumber <= 40) then
        itemtype = "bherb"
    elseif (itemnumber == 46 ) then
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

	--self:BecomeRagdoll( dmginfo )
    SafeRemoveEntity( self )
    
end

function ENT:OnStuck( )

end

function ENT:HandleStuck()

    self.loco:ClearStuck()

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


function util.randRadius(origin, min, max)
	max = max or min
	distance = math.random(min, max)
	angle = math.random(0, 360)
	return origin + Vector(math.cos(angle) * distance, math.sin(angle) * distance, 0)
end


function ENT:Gib(dmginfo)
    local gibs = {}
    for i = 1, math.random(2,6) do
        local data = table.Random(gibmods)
        local gib = ents.Create("prop_physics")
        gib:SetModel(data.Model)
        gib:SetMaterial(data.Material or "")
        gib:SetPos(self:GetPos() + self:GetAngles():Up() * math.random(20,70))
        gib:Spawn()
        gib:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
        if IsValid(gib:GetPhysicsObject()) then
          gib:GetPhysicsObject():ApplyForceCenter(dmginfo:GetDamageForce() * (math.random(1,20)/20))
        end
        table.insert(gibs,gib)
    end
    local pos = self:GetPos()

    self:Remove()

    local visual = EffectData()
    visual:SetOrigin( pos + Vector(0,0,40) )
    util.Effect("BloodImpact", visual )

    util.Decal( "Blood", pos,  pos - Vector(0,0,20))

    for i = 1, math.random(1,4) do
        local surroundPos = util.randRadius( pos, 10, 20 )
        util.Decal( "Blood", surroundPos,  surroundPos - Vector(0,0,20))

        local visual = EffectData()
        visual:SetOrigin( pos + Vector(0,0,40) )
        util.Effect("BloodImpact", visual )

    end

    timer.Simple(30,function() for _,gib in pairs(gibs) do if gib:IsValid() then gib:Remove() end end end )
end

function ENT:hitBody( hitgroup, dmginfo )

end

-- function ENT:OnTakeDamage(dmg)
--     self:SetHealth(self:Health() - dmg:GetDamage())
--     if self:Health() <= 0 then
--         self:Perish(dmg)
--     end
-- end

-- function ENT:Perish(dmg)
--     if self:Health() < -35 && dmg:IsExplosionDamage() then
--         self:Explode(dmg)
--     else
--         self:Ragdoll(dmg)
--     end
--     classAIDirector.npcDeath(self, dmg:GetAttacker(), dmg:GetInflictor())
--     self:Remove()
-- end

-- -- ONLY NEED THIS FOR A BODY
-- function ENT:Ragdoll(dmgforce)
--     local ragdoll = ents.Create("prop_ragdoll")
--     ragdoll:SetModel(self:GetModel())
--     ragdoll:SetPos(self:GetPos())
--     ragdoll:SetAngles(self:GetAngles())
--     ragdoll:SetVelocity(self:GetVelocity())
--     ragdoll:Spawn()
--     ragdoll:Activate()
--     ragdoll:SetCollisionGroup(1)
--     ragdoll:GetPhysicsObject():ApplyForceCenter(dmgforce:GetDamageForce())

--     local function FadeOut(ragdoll)
--         --Polkm: This will work better then the old one
--         local Steps = 30
--         local TimePerStep = 0.05
--         local CurentAlpha = 255
--         for i = 1, Steps do
--             timer.Simple(i * TimePerStep, function()
--                 if ragdoll:IsValid() then
--                     CurentAlpha = CurentAlpha - (255 / Steps)
--                     ragdoll:SetColor(255, 255, 255, CurentAlpha)
--                 end
--             end)
--         end
--         timer.Simple(Steps * TimePerStep, function() if ragdoll:IsValid() then ragdoll:Remove() end end)
--     end
--     timer.Simple(15, function() if ragdoll:IsValid() then FadeOut(ragdoll) end end)
-- end

-- local delay = 0
-- function ENT:Think()

-- end

-- function ENT:SelectSchedule( INPCState )

-- end


ENT.AttackSounds = {
	"zombie_male/zom_attack.wav",
	"zombie_male/arms_lunge1.wav",
	"zombie_male/arms_lunge2.wav",
	"zombie_male/arms_lunge3.wav",
}

function ENT:setAttackSounds(newAttackSounds)
    self.AttackSounds = newAttackSounds
end

function ENT:getAttackSounds()
    return self.AttackSounds
end

ENT.AttackAnims = {
    "attackA",
    "attackB",
    "attackC"
}
function ENT:setAttackAnims(newAttackAnims)
    self.AttackAnims = newAttackAnims
end

function ENT:getAttackAnims()
    return self.AttackAnims
end

ENT.InfectionChance = .25
function ENT:setInfectionChance(newInfectionChance)
    self.InfectionChance = newInfectionChance
end

function ENT:getInfectionChance()
    return self.InfectionChance
end

ENT.AttackSpeed = 4
function ENT:setAttackSpeed(attackSpeed)
    self.AttackSpeed = attackSpeed
end

function ENT:getAttackSpeed()
    return self.AttackSpeed
end

ENT.AttackDamage = 10
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

----------------------------------------------------
-- ENT:Get/SetEnemy()
-- Simple functions used in keeping our enemy saved
----------------------------------------------------
function ENT:SetEnemy(ent)
	self.Enemy = ent
end
function ENT:GetEnemy()
	return self.Enemy
end



function ENT:RunBehaviour()

	while ( true ) do
	if self:HaveEnemy() then

		local enemy = self:GetEnemy()
		self:StartActivity( ACT_RUN )
		local dif = GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier * 10
		self.loco:SetDesiredSpeed( math.random(25+dif,75+dif) )

		pos = enemy:GetPos()

		if ( pos ) then

			if enemy:Health() > 0 and enemy:IsValid() then

				self.HasNoEnemy = false

				local opts = {	lookahead = 300,
					tolerance = 20,
					draw = false,
					maxage = 1,
					repath = 1	}
				self:ChaseEnemy( pos, opts )

			end

		end

	end
		coroutine.yield()
	end
end

----------------------------------------------------
-- ENT:ChaseEnemy()
-- Works similarly to Garry's MoveToPos function
-- except it will constantly follow the
-- position of the enemy until there no longer
-- is one.
----------------------------------------------------
function ENT:ChaseEnemy( options )

	local options = options or {}

	local path = Path( "Follow" )
	path:SetMinLookAheadDistance( options.lookahead or 300 )
	path:SetGoalTolerance( options.tolerance or 20 )
	path:Compute( self, self:GetEnemy():GetPos() )		-- Compute the path towards the enemy's position

	if ( !path:IsValid() ) then return "failed" end

	while ( path:IsValid() and self:HaveEnemy() ) do

		if ( path:GetAge() > 0.1 ) then					-- Since we are following the player we have to constantly remake the path
			path:Compute( self, self:GetEnemy():GetPos() )-- Compute the path towards the enemy's position again
		end
		path:Update( self )								-- This function moves the bot along the path

		if ( options.draw ) then path:Draw() end
		-- If we're stuck then call the HandleStuck function and abandon
		if ( self.loco:IsStuck() ) then
			self:HandleStuck()
			return "stuck"
		end

		coroutine.yield()
        for key, ent in pairs(ents.FindInSphere(self:GetPos(), 45)) do
            if (ent:IsPlayer()) && (ent:Team() == TEAM_HUNK ) then
                self:AttackEntity(ent)
            end
        end
        
        for gg, ent2 in pairs(ents.FindInSphere(self:GetPos(), 45 )) do
            if (IsValid(ent2) && self:CheckProp(ent2)) then
               self:AttackEntity(ent2)
            end
        end
		

	end

	return "ok"

end

----------------------------------------------------
-- ENT:HaveEnemy()
-- Returns true if we have an enemy
----------------------------------------------------
function ENT:HaveEnemy()
	-- If our current enemy is valid
	if ( self:GetEnemy() and IsValid(self:GetEnemy()) ) then
        -----------Attack--------
		-- If the enemy is too far
		if ( self:GetRangeTo(self:GetEnemy():GetPos()) > self.LoseTargetDist ) then
			-- If the enemy is lost then call FindEnemy() to look for a new one
			-- FindEnemy() will return true if an enemy is found, making this function return true
			return self:FindEnemy()
		-- If the enemy is dead( we have to check if its a player before we use Alive() )
		elseif ( self:GetEnemy():IsPlayer() and !self:GetEnemy():Alive() ) then
			return self:FindEnemy()		-- Return false if the search finds nothing
		end
		-- The enemy is neither too far nor too dead so we can return true
		return true
	else
		-- The enemy isn't valid so lets look for a new one
		return self:FindEnemy()
	end

end

----------------------------------------------------
-- ENT:FindEnemy()
-- Returns true and sets our enemy if we find one
----------------------------------------------------
function ENT:FindEnemy()

    --[[

    local pos = self:GetPos()

    local min_dist, closest_target = -1, nil

    for _, target in pairs(player.GetAll()) do
        if (IsValid(target)&&target:Alive()&&target:Team() != TEAM_CROWS&&GetGlobalString("Mode") != "End"&&target:GetMoveType() == MOVETYPE_WALK) then
            local dist = target:NearestPoint(pos):Distance(pos)
            if ((dist < min_dist||min_dist==-1)) then
                closest_target = target
                min_dist = dist
                self:SetEnemy( target )
            end
        end
    end

    return closest_target

    ]]--

    



    local target = nil
    for key, ply in pairs(player.GetAll()) do
        if ply:Team() != TEAM_CROWS && ply:Alive() && GetGlobalString("Mode") != "End" then
            if (!IsValid(target) or ply:GetPos():Distance( self:GetPos() ) < target:GetPos():Distance(self:GetPos())) then
                target = ply
            end
        end
    end

    self:SetEnemy( target )
    return target
end




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

function ENT:AttackEntity( entity, options )
	if !self.nxtAttack then self.nxtAttack = 0 end
    if CurTime() < self.nxtAttack then return end

        self.nxtAttack = CurTime() + 1

            timer.Simple(0.5, function()

                if !self:IsValid() then return end
                if self:Health() < 0 then return end

                if IsValid(entity) then

                    if ( self:GetRangeTo(entity) < 45 and IsValid(entity) ) then

                        if entity:IsPlayer() then
							local dif = GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier
                            entity:TakeDamage(self.BaseDamage + dif, self)
                            local soundPath = table.Random(self:getAttackSounds())
                            local chance = math.random(1,5)
                            if chance == 1 then
                                sound.Play(soundPath, self:GetPos() + Vector(0,0,50), 75, 100, 1 )
                            end
                            entity:ViewPunch(Angle(math.random(-1, 1)*self.BaseDamage, math.random(-1, 1)*self.BaseDamage, math.random(-1, 1)*self.BaseDamage))
                            
                            local bleed = ents.Create("info_particle_system")
                            bleed:SetKeyValue("effect_name", "blood_impact_red_01")
                            bleed:SetPos(entity:GetPos() + Vector(0,0,70))
                            bleed:Spawn()
                            bleed:Activate()
                            bleed:Fire("Start", "", 0)
                            bleed:Fire("Kill", "", 0.2)

                            local moveAdd=Vector(0,0,150)
                            if not entity:IsOnGround() then
                                moveAdd=Vector(0,0,0)
                            end
                            entity:SetVelocity(moveAdd+((entity:GetPos()-self:GetPos()):GetNormal()*10)) -- apply the velocity
                        else
                            entity:TakeDamage(self.BaseDamage, self)
                        end
                    else
                        self:EmitSound("weapons/stunstick/stunstick_swing2.wav")
                    end
                    
                end

            end)
            self:PlaySequenceAndWait( table.Random(self:getAttackAnims()), 2 )



		self:StartActivity( ACT_RUN )

        
	return "ok"
end

function ENT:AttackEnemy( options )
    self:AttackEntity(self:GetEnemy(), options)
end
