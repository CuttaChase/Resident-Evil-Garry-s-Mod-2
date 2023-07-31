AddCSLuaFile()

ENT.Base 			= "base_nextbot"
ENT.Spawnable		= false
ENT.BaseDamage 		= math.random(2,5)

ENT.Owner 			= nil
ENT.AttackRange = 35
ENT.NextAttack = 1.2

ENT.WalkAnim = "walk_melee"
ENT.IdleAnim = "idle"
ENT.SearchRadius = 100
ENT.LoseTargetDist = 500
ENT.ModelScale = 0.9

local pain = {"dog_ouch_strong0.wav",
"dog_ouch_strong1.wav",
"dog_ouch_strong3.wav",
"dog_ouch0.wav",
"dog_ouch1.wav",
"dog_ouch2.wav"}


local idl = {"dog_misc0.wav",
"dog_misc1.wav",
"dog_misc2.wav"}

local warn = {"dog_dying0.wav",
"dog_dying1.wav"}


function ENT:Initialize()
    self:SetModel( "models/player/slow/amberlyn/re5/dog/slow.mdl"  );
	self:DrawShadow(false)
	--self:SetCustomCollisionCheck( true )
	self.Entity:SetCollisionBounds( Vector(-15,-15,0), Vector(15,15,56) )
	self:SetCollisionGroup(COLLISION_GROUP_NPC_SCRIPTED)
	self:SetModelScale( self.ModelScale, 0.8 )

	self:SetHealth(math.random(20,60))
	
	self:EmitSound(table.Random(idl),110,170)
	self.SearchRadius = 50
	self.LoseTargetDist = 500

end

function ENT:OnInjured(dmg)
	local c = math.random(1,5)
	if(dmg:GetAttacker():IsPlayer() || dmg:GetAttacker():IsNPC()) then
		self.Enemy = dmg:GetAttacker()
	end
	if(c == 1) then
		self:EmitSound(table.Random(pain),75,170)
	end
	local dmg = dmg
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

local die = {"dog_ouch_strong0.wav",
"dog_ouch_strong1.wav",
"dog_ouch_strong2.wav",
"dog_ouch0",
"dog_ouch2"}

function ENT:OnKilled( dmginfo )
local dmg = dmginfo
    local killer = dmg:GetAttacker()
  	if killer:IsPlayer() then
  		local old = killer:GetNWInt("killcount")
  		killer:SetNWInt("killcount", old + 1)
  		local oldm = killer:GetNWInt("Money")
  		killer:SetNWInt("Money", oldm + 2 * GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier )

  	end
	NumZombies = NumZombies - 1
	if(IsValid(dmginfo:GetAttacker()) && dmginfo:GetAttacker():IsPlayer()) then
		dmginfo:GetAttacker():AddFrags(1)
		hook.Call( "OnNPCKilled", GAMEMODE, self, dmginfo:GetAttacker(), dmginfo:GetInflictor() )
	end
  	if self.Flame != nil then
  		if self.Flame:IsValid() then
  			self.Flame:Remove()
  		end
  	end

  	--SetGlobalInt("RE2_DeadZombies", GetGlobalInt("RE2_DeadZombies") + 1)
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
    elseif (itemnumber == 46 ) then
        itemtype = "money"
	end
	if itemtype != "lol" then
		local item = ents.Create("item_"..itemtype)
		item:SetPos(self.Entity:GetPos())
		item:Spawn()
		item:Activate( )
		timer.Simple(30, function() if item:IsValid() then item:Remove() end end)
	end
	SafeRemoveEntity( self )
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

ENT.State = 0
ENT.Enemy = nil
ENT.CanAttack = false

function ENT:IsNPC()
	return true
end

----------------------------------------------------
-- ENT:Get/SetEnemy()
-- Simple functions used in keeping our enemy saved
----------------------------------------------------
function ENT:SetEnemy( ent )
	self.Enemy = nil
end
function ENT:GetEnemy()
	return self.Enemy
end

local claw = {"dog_dying0.wav",
"dog_dying1.wav",
"dog_dying2.wav"}
ENT.AttackAnims = {"AttackA","AttackB","AttackC","AttackD","AttackE","AttackF"}

function ENT:DispatchAttack(entity, options)
	if !self.nxtAttack then self.nxtAttack = 0 end
    if CurTime() < self.nxtAttack then return end

        self.nxtAttack = CurTime() + 3
		entity = self.Enemy
		if ( (entity:IsValid() ) ) then


		    self.Enemy = self.Enemy
            self:SetPoseParameter("move_x",0)
            
            
            

            timer.Simple(0.5, function()
                if !self:IsValid() then return end
                if self:Health() < 0 then return end

                if self.IsFlinching or self.IsReviving then return end
                if entity:IsValid() then
                    if (self:GetRangeTo(entity) < 45) then

                        if entity:IsPlayer() then
                        entity:TakeDamage(self.BaseDamage, self)
                        self:EmitSound(claw[math.random(1,3)],75)
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
                    end
                end

            end)
            self:SetSequence(self.AttackAnims[math.random(1,#self.AttackAnims)],1)



		self:StartActivity( ACT_RUN )
		self:SetPoseParameter("move_x",1)
        end
        
	return "ok"
end


----------------------------------------------------
-- ENT:Get/SetEnemy()
-- Simple functions used in keeping our enemy saved
----------------------------------------------------
function ENT:SetEnemy( ent )
	self.Enemy = ent
end
function ENT:GetEnemy()
	return self.Enemy
end


function ENT:Nope()

	self.Enemy = nil
end




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

----------------------------------------------------
-- ENT:RunBehaviour()
-- This is where the meat of our AI is
----------------------------------------------------
function ENT:RunBehaviour()

	while ( true ) do
	if self:HaveEnemy() then

		local enemy = self:GetEnemy()
		self:StartActivity( ACT_RUN )
		self.loco:SetDesiredSpeed( 350 )

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
		self:DispatchAttack()

	end

	return "ok"

end




list.Set( "NPC", "simple_nextbot", {
	Name = "Simple bot",
	Class = "simple_nextbot",
	Category = "NextBot"
} )
