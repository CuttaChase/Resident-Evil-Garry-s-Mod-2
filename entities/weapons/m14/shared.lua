------------------------------------------------------
//Sauce, Duke of Pasta's SWep Base
-- SCK Base Code by Clavus
--Started from Bummiehead's Example SWep Base Code
------------------------------------------------------
DEFINE_BASECLASS( "gunbase" )
-------------------------
//General Attributes
-------------------------

SWEP.ViewModel = "models/weapons/v_m14_galil.mdl"      
SWEP.WorldModel = "models/weapons/w_rif_galil.mdl"
SWEP.ViewModelFOV	= 50
SWEP.ViewModelFlip = false
SWEP.BobScale = 1
SWEP.SwayScale = -2
SWEP.SetDeploySpeed = 2.0
SWEP.UseHands = true
SWEP.Primary.ReloadingTime = 3
-----------------------
//SCK Elements
-----------------------
SWEP.ViewModelBoneMods = {}

SWEP.VElements = {}

SWEP.WElements = {}

SWEP.Slot = 3
SWEP.SlotPos = 0 
SWEP.Category = "Vintage Firearms"                             
SWEP.HoldType = "ar2"                            
SWEP.PrintName = "M14"                        
SWEP.Author = "It's Sauce-Some!" 
SWEP.Purpose = " "         
SWEP.Instructions = " "              
SWEP.Contact = " "

SWEP.Spawnable = true 
SWEP.AdminSpawnable = true                              
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false                         
SWEP.FiresUnderwater = true                        
SWEP.Weight = 5                                    
SWEP.DrawCrosshair = false                           
SWEP.DrawAmmo = true                                
SWEP.ReloadSound = "Weapon_smg1.Reload"                               
SWEP.CSMuzzleFlashes = true
SWEP.MuzzleAttachment = "1"
SWEP.ShellEjectAttachment = "2"
SWEP.NextFireSelect = CurTime() + 0.5

SWEP.IronSightsPos = Vector(-4.97, -4.422, 2.599)
SWEP.IronSightsAng = Vector(-0.101, 0, 0)

SWEP.SprintPos = Vector(8.64, -11.721, 1)
SWEP.SprintAng = Vector(-14.4, 59.4, 0)

SWEP.RestPos = Vector(-2.161, -8.83, -8.4)
SWEP.RestPos = Vector(37.2, -1.8, 0)

sound.Add( {
		name = "sauce_aim",
		channel = CHAN_STATIC,
		volume = 1.0,
		level = 80,
		pitch = {95, 110},
		sound = "weapons_m14/cloth-9.wav"
	} )

--------------------------
//Primary Attributes
--------------------------
SWEP.Primary.Sound = "weapons_m14/galil-1.wav"        
SWEP.Primary.Damage = 40                     
SWEP.Primary.TakeAmmo = 1                        
SWEP.Primary.ClipSize = 20
SWEP.Primary.DefaultClip = 60                       
SWEP.Primary.Ammo = "ar2"                        
SWEP.Primary.Spread = 0.12   
SWEP.Primary.EffectiveRange = 1500                       
SWEP.Primary.NumberofShots = 1                  
SWEP.Primary.Automatic = false
SWEP.Primary.Delay = 0.13                         
SWEP.Primary.Force = 1                     
SWEP.Primary.KickUp = 1.5                      
SWEP.Primary.KickSides = 0.7

-------------------------
//Secondary Attributes
-------------------------
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"
SWEP.SecondaryIronFOV = 50
SWEP.Secondary.Sound = "sauce_aim"                      
SWEP.Secondary.Delay = 0.1                         // Probably pointless, but keep it here just 'cuz
SWEP.NextSecondaryAttack = 0
local IRONSIGHT_TIME = SWEP.Weight *.05

function SWEP:Initialize()

	util.PrecacheSound(self.Primary.Sound)
	util.PrecacheSound(self.Secondary.Sound)
	
		self:SetWeaponHoldType( self.HoldType )

	if CLIENT then


		// Create a new table for every weapon instance
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )


		self:CreateModels(self.VElements) // create viewmodels
		self:CreateModels(self.WElements) // create worldmodels


		// init view model bone build function
		if IsValid(self.Owner) then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)


				// Init viewmodel visibility
				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(Color(255,255,255,255))
				else
					// we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
					vm:SetColor(Color(255,255,255,1))
					// ^ stopped working in GMod 13 because you have to do Entity:SetRenderMode(1) for translucency to kick in
					// however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
					vm:SetMaterial("Debug/hsv")			
				end
			end
		end


	end
	
concommand.Add("sauce_viewbob", function() 
if self.Weapon:GetNetworkedBool("VBEnabled") then
		self.Weapon:SetNetworkedBool("VBEnabled", false)
		if CLIENT then
		self.Owner:PrintMessage(HUD_PRINTTALK, "View bobbing is now disabled")
		end
	else
		self.Weapon:SetNetworkedBool("VBEnabled", true)
		if CLIENT then
		self.Owner:PrintMessage(HUD_PRINTTALK, "View bobbing is now enabled")
		end
	end


end)

end

function SWEP:Deploy()
self.Weapon:SetNetworkedBool("Ironsights", false)
self.Weapon:SetNetworkedBool("reloading", false)
self.Weapon:SetNetworkedBool("VBEnabled", true)

self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
self:SetPlaybackRate(1)

	return BaseClass.Deploy( self )
	
end

function SWEP:Holster()

	if CLIENT and IsValid(self.Owner) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end
hook.Remove("PlayerFootstep", "ViewBob")

	return true
end

function SWEP:OnRemove()
	self:Holster()
end

function SWEP:FireMode()

	if self.Primary.Automatic then
	self.Primary.Automatic = false
	self.NextFireSelect = CurTime() + 0.5
	self.Weapon:EmitSound(Sound("Weapon_pistol.Empty"))
		if CLIENT then
		self.Owner:PrintMessage(HUD_PRINTTALK, "Semi-Automatic")
		end
	elseif !self.Primary.Automatic then
	self.Primary.Automatic = true
	self.NextFireSelect = CurTime() + 0.5
	self.Weapon:EmitSound(Sound("Weapon_pistol.Empty"))
		if CLIENT then
		self.Owner:PrintMessage(HUD_PRINTTALK, "Automatic")
		end
	end
	
end	



------------------------------
//Primary Fire
------------------------------
function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	local bullet = {}
		bullet.Num = self.Primary.NumberofShots
		bullet.Src = self.Owner:GetShootPos()
		bullet.Dir = self.Owner:GetAimVector()
		bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
		bullet.Tracer = 1
		bullet.TracerName = "Tracer"
		bullet.Force = self.Primary.Force
		bullet.Damage = self.Primary.Damage
		bullet.AmmoType = self.Primary.Ammo
	local rnda = self.Primary.KickUp * -1
	local rndb = self.Primary.KickSides * math.random(-0.5, 0.5)
	self:ShootEffects()
	self.Owner:FireBullets( bullet )
	self.Weapon:EmitSound(Sound(self.Primary.Sound))
	self.Owner:ViewPunch( Angle( rnda,rndb,rndb ) )
	self:TakePrimaryAmmo(self.Primary.TakeAmmo)
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self.Weapon:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )

end

local damage = SWEP.Primary.Damage

function SWEP:OnFire()
// Adjust the player's aim
	local view = self.Owner:EyeAngles()
	local recoil = Angle( (-self.Primary.KickUp)*.6, math.Rand(self.Primary.KickSides, -self.Primary.KickSides)*.5,0 )

	local view = view + recoil
	self.Owner:SetEyeAngles(view)
	
	local num = self.Owner:EyeAngles()
	// Muzzle effects
		local muzzleattachment = self.Weapon:LookupAttachment(self.MuzzleAttachment)
		local muzzledata = EffectData{}
			muzzledata:SetEntity(self.Weapon)
			muzzledata:SetAttachment(muzzleattachment)
			muzzledata:SetAngles(self.Weapon:GetAttachment(muzzleattachment).Ang)
			muzzledata:SetNormal( self.Weapon:GetAttachment(muzzleattachment).Ang:Forward() )
			//muzzledata:SetStart(self.Weapon:GetAttachment(muzzleattachment).pos)
			if self.Owner:KeyDown(IN_DUCK) then
				muzzledata:SetOrigin(self.Weapon:GetAttachment(muzzleattachment).Pos + Vector(0,0,30))
			else
				muzzledata:SetOrigin(self.Weapon:GetAttachment(muzzleattachment).Pos + Vector (0,0,65))
			end
			muzzledata:SetScale(1)

		util.Effect("MuzzleEffect", muzzledata)
		util.Effect("", muzzledata)
		
	// Shell eject
		local ejectattachment = self.Weapon:LookupAttachment(self.ShellEjectAttachment)
		local shelldata = EffectData{}
			shelldata:SetEntity(self.Weapon)
			shelldata:SetAttachment(ejectattachment)
			shelldata:SetAngles(self.Weapon:GetAttachment(ejectattachment).Ang)
			shelldata:SetNormal( self.Weapon:GetAttachment(ejectattachment).Ang:Right() )
			//shelldata:SetStart(self.Weapon:GetAttachment(ejectattachment).Pos)
			if self.Owner:KeyDown(IN_DUCK) then
				shelldata:SetOrigin(self.Weapon:GetAttachment(ejectattachment).Pos + Vector(0,0,30))
			else
				shelldata:SetOrigin(self.Weapon:GetAttachment(ejectattachment).Pos + Vector(0,0,65))
			end
			shelldata:SetScale(1)
		
		util.Effect("RifleShellEject", shelldata)
	
end


function SWEP:FireAnimationEvent( position, angles, event, options )
	//print( "FireAnimationEvent", position, angles, event, options );
    -- Disables animation based muzzle event
    if (event == 20) then return true end  
     
    -- Disable thirdperson muzzle flash
    if (event == 5001) then return true end
end

function SWEP:ShootEffects()

	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Owner:MuzzleFlash()
	
end


-------------------------
//Think
-------------------------
function SWEP:Think()

	if self.Owner:KeyDown(IN_USE) and self.Owner:KeyPressed(IN_ATTACK2) and self.NextFireSelect < CurTime() then
	if self.Weapon:GetNetworkedBool("reloading") then return end
	self:FireMode()
	end
	
	
end
	

function SWEP:SetIronsights(b)
	self.Weapon:SetNetworkedBool("Ironsights", b)
end

function SWEP:GetViewModelPosition(pos, ang)


	if (!self.IronSightsPos) then return pos, ang end
	

	local bmIron = self.Weapon:GetNetworkedBool("Ironsights")
	
	if (bmIron != self.bmLastIron) then
	
		self.bmLastIron = bmIron 
		self.fmIronTime = CurTime()
		
		if (bmIron) then 
			self.SwayScale 	= -0.3
			self.BobScale 	= 0.2
			self.DrawCrosshair = false

		else 
			self.SwayScale 	= -2
			self.BobScale 	= 1.0
			self.DrawCrosshair = false

		end
	
	end
	
	
	local fmIronTime = self.fmIronTime or 0

	if (!bmIron and fmIronTime < CurTime() - IRONSIGHT_TIME) then 
		return pos, ang 
	end
	
	local Mul = 1.0
	
	if (fmIronTime > CurTime() - IRONSIGHT_TIME) then
	
		Mul = math.Clamp((CurTime() - fmIronTime) / IRONSIGHT_TIME, 0, 1)
		
		if (!bmIron) then Mul = 1 - Mul end
	
	end

	local Offset	= self.IronSightsPos
	
	if (self.IronSightsAng) then
	
		ang = ang * 1
		ang:RotateAroundAxis(ang:Right(), self.IronSightsAng.x * Mul)
		ang:RotateAroundAxis(ang:Up(), self.IronSightsAng.y * Mul)
		ang:RotateAroundAxis(ang:Forward(), self.IronSightsAng.z * Mul)
		
	
	end
	
	local Right 	= ang:Right()
	local Up 		= ang:Up()
	local Forward 	= ang:Forward()
	
	

	pos = pos + Offset.x * Right * Mul
	pos = pos + Offset.y * Forward * Mul
	pos = pos + Offset.z * Up * Mul

	return pos, ang
	
end

--------------------------------
//Secondary Fire
--------------------------------
function SWEP:SecondaryAttack()

	if (!self.IronSightsPos) then return end
	if (self.NextSecondaryAttack > CurTime()) then return end
	if self.Owner:KeyDown(IN_USE) or self.Owner:KeyDown(IN_SPEED) then return end
	
	bmIronsights = !self.Weapon:GetNetworkedBool("Ironsights", false)
	self.Weapon:EmitSound(Sound(self.Secondary.Sound))
	self:SetIronsights(bmIronsights)
	
	self.NextSecondaryAttack = CurTime() + 0.3
end

local clip = SWEP.Primary.ClipSize

----------------------------
//Reload
----------------------------
function SWEP:Reload()
 
	self.Weapon:SetNetworkedBool("reloading", true)
	timer.Simple(self.Owner:GetViewModel():SequenceDuration(), function()
	self.Weapon:SetNetworkedBool("reloading", false)

	if (self:GetOwner():GetAmmoCount(self.Primary.Ammo) + self.Weapon:Clip1()) >= self.Primary.ClipSize then
		if SERVER && CurTime() >= self.ReloadingTime then
			self:GetOwner():RemoveAmmo(self.Primary.ClipSize - self.Weapon:Clip1()  ,self.Primary.Ammo )
			self.Weapon:SetClip1(self.Primary.ClipSize)
			self.Weapon:EmitSound(Sound(self.ReloadSound))
			self.Weapon:SendWeaponAnim(ACT_VM_RELOAD)
		end
	else
		if SERVER && CurTime() >= self.ReloadingTime then
			self.Weapon:SetClip1(self:GetOwner():GetAmmoCount(self.Primary.Ammo) + self.Weapon:Clip1())
			self:GetOwner():RemoveAmmo(self:GetOwner():GetAmmoCount(self.Primary.Ammo),self.Primary.Ammo)
			self.Weapon:EmitSound(Sound(self.ReloadSound))
			self.Weapon:SendWeaponAnim(ACT_VM_RELOAD)
		end
	end

	end)

	self:DefaultReload( ACT_VM_RELOAD )
			local AnimationTime = self.Owner:GetViewModel():SequenceDuration()
			self.ReloadingTime = CurTime() + AnimationTime
			self:SetNextPrimaryFire(CurTime() + AnimationTime)
			self:SetNextSecondaryFire(CurTime() + AnimationTime)
			self:SetNetworkedBool ("Ironsights", false)


end



----------------------
//SCK Base Code
----------------------
if CLIENT then


	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()


		local vm = self.Owner:GetViewModel()
		if !IsValid(vm) then return end


		if (!self.VElements) then return end


		self:UpdateBonePositions(vm)


		if (!self.vRenderOrder) then


			// we build a render order because sprites need to be drawn after models
			self.vRenderOrder = {}


			for k, v in pairs( self.VElements ) do
				if (v.type == "Model") then
					table.insert(self.vRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.vRenderOrder, k)
				end
			end


		end


		for k, name in ipairs( self.vRenderOrder ) do


			local v = self.VElements[name]
			if (!v) then self.vRenderOrder = nil break end
			if (v.hide) then continue end


			local model = v.modelEnt
			local sprite = v.spriteMaterial


			if (!v.bone) then continue end


			local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )


			if (!pos) then continue end


			if (v.type == "Model" and IsValid(model)) then


				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)


				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )


				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end


				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end


				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end


				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end


				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)


				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end


			elseif (v.type == "Sprite" and sprite) then


				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)


			elseif (v.type == "Quad" and v.draw_func) then


				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)


				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()


			end


		end


	end


	SWEP.wRenderOrder = nil
	function SWEP:DrawWorldModel()


		if (self.ShowWorldModel == nil or self.ShowWorldModel) then
			self:DrawModel()
		end


		if (!self.WElements) then return end


		if (!self.wRenderOrder) then


			self.wRenderOrder = {}


			for k, v in pairs( self.WElements ) do
				if (v.type == "Model") then
					table.insert(self.wRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.wRenderOrder, k)
				end
			end


		end


		if (IsValid(self.Owner)) then
			bone_ent = self.Owner
		else
			// when the weapon is dropped
			bone_ent = self
		end


		for k, name in pairs( self.wRenderOrder ) do


			local v = self.WElements[name]
			if (!v) then self.wRenderOrder = nil break end
			if (v.hide) then continue end


			local pos, ang


			if (v.bone) then
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
			else
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
			end


			if (!pos) then continue end


			local model = v.modelEnt
			local sprite = v.spriteMaterial


			if (v.type == "Model" and IsValid(model)) then


				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)


				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )


				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end


				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end


				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end


				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end


				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)


				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end


			elseif (v.type == "Sprite" and sprite) then


				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)


			elseif (v.type == "Quad" and v.draw_func) then


				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)


				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()


			end


		end


	end


	function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )


		local bone, pos, ang
		if (tab.rel and tab.rel != "") then


			local v = basetab[tab.rel]


			if (!v) then return end


			// Technically, if there exists an element with the same name as a bone
			// you can get in an infinite loop. Let's just hope nobody's that stupid.
			pos, ang = self:GetBoneOrientation( basetab, v, ent )


			if (!pos) then return end


			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)


		else


			bone = ent:LookupBone(bone_override or tab.bone)


			if (!bone) then return end


			pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = ent:GetBoneMatrix(bone)
			if (m) then
				pos, ang = m:GetTranslation(), m:GetAngles()
			end


			if (IsValid(self.Owner) and self.Owner:IsPlayer() and 
				ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
				ang.r = -ang.r // Fixes mirrored models
			end


		end


		return pos, ang
	end


	function SWEP:CreateModels( tab )


		if (!tab) then return end


		// Create the clientside models here because Garry says we can't do it in the render hook
		for k, v in pairs( tab ) do
			if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then


				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
				if (IsValid(v.modelEnt)) then
					v.modelEnt:SetPos(self:GetPos())
					v.modelEnt:SetAngles(self:GetAngles())
					v.modelEnt:SetParent(self)
					v.modelEnt:SetNoDraw(true)
					v.createdModel = v.model
				else
					v.modelEnt = nil
				end


			elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
				and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then


				local name = v.sprite.."-"
				local params = { ["$basetexture"] = v.sprite }
				// make sure we create a unique name based on the selected options
				local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
				for i, j in pairs( tocheck ) do
					if (v[j]) then
						params["$"..j] = 1
						name = name.."1"
					else
						name = name.."0"
					end
				end


				v.createdSprite = v.sprite
				v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)


			end
		end


	end


	local allbones
	local hasGarryFixedBoneScalingYet = false


	function SWEP:UpdateBonePositions(vm)


		if self.ViewModelBoneMods then


			if (!vm:GetBoneCount()) then return end


			// !! WORKAROUND !! //
			// We need to check all model names :/
			local loopthrough = self.ViewModelBoneMods
			if (!hasGarryFixedBoneScalingYet) then
				allbones = {}
				for i=0, vm:GetBoneCount() do
					local bonename = vm:GetBoneName(i)
					if (self.ViewModelBoneMods[bonename]) then 
						allbones[bonename] = self.ViewModelBoneMods[bonename]
					else
						allbones[bonename] = { 
							scale = Vector(1,1,1),
							pos = Vector(0,0,0),
							angle = Angle(0,0,0)
						}
					end
				end


				loopthrough = allbones
			end
			// !! ----------- !! //


			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone(k)
				if (!bone) then continue end


				// !! WORKAROUND !! //
				local s = Vector(v.scale.x,v.scale.y,v.scale.z)
				local p = Vector(v.pos.x,v.pos.y,v.pos.z)
				local ms = Vector(1,1,1)
				if (!hasGarryFixedBoneScalingYet) then
					local cur = vm:GetBoneParent(bone)
					while(cur >= 0) do
						local pscale = loopthrough[vm:GetBoneName(cur)].scale
						ms = ms * pscale
						cur = vm:GetBoneParent(cur)
					end
				end


				s = s * ms
				// !! ----------- !! //


				if vm:GetManipulateBoneScale(bone) != s then
					vm:ManipulateBoneScale( bone, s )
				end
				if vm:GetManipulateBoneAngles(bone) != v.angle then
					vm:ManipulateBoneAngles( bone, v.angle )
				end
				if vm:GetManipulateBonePosition(bone) != p then
					vm:ManipulateBonePosition( bone, p )
				end
			end
		else
			self:ResetBonePositions(vm)
		end


	end


	function SWEP:ResetBonePositions(vm)


		if (!vm:GetBoneCount()) then return end
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
			vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
			vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
		end


	end


	/**************************
		Global utility code
	**************************/


	// Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
	// Does not copy entities of course, only copies their reference.
	// WARNING: do not use on tables that contain themselves somewhere down the line or you'll get an infinite loop
	function table.FullCopy( tab )


		if (!tab) then return nil end


		local res = {}
		for k, v in pairs( tab ) do
			if (type(v) == "table") then
				res[k] = table.FullCopy(v) // recursion ho!
			elseif (type(v) == "Vector") then
				res[k] = Vector(v.x, v.y, v.z)
			elseif (type(v) == "Angle") then
				res[k] = Angle(v.p, v.y, v.r)
			else
				res[k] = v
			end
		end


		return res


	end


end
