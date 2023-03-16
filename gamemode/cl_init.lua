include( "config.lua" )
include( "shared.lua" )
include( "cl/cl_hud.lua" )
include( "cl/cl_scoreboard.lua" )
include( "cl/cl_net.lua" )
include( "cl/cl_music.lua" )
include( "modules/upgrades.lua" )

if not MENU then MENU = {} end
include( "vgui/vgui_framework.lua" )
include( "vgui/vgui_options.lua" )
include( "vgui/vgui_inventory.lua" )
include( "vgui/vgui_merchantmenu.lua" )
include( "vgui/vgui_votemenu.lua" )
include( "vgui/vgui_adminmenu.lua" )
include( "vgui/vgui_hud.lua" )
include( "vgui/vgui_skills.lua" )


CV_LaserRed = CreateClientConVar( "cl_regmod_lasercol_r", "0", true, false )
CV_LaserBlue = CreateClientConVar( "cl_regmod_lasercol_b", "255", true, false )
CV_LaserGreen = CreateClientConVar( "cl_regmod_lasercol_g", "200", true, false )

CV_EnableView = CreateClientConVar( "cl_regmod_enableview", "1", true, false )
CV_EnableMusic = CreateClientConVar( "cl_regmod_enablemusic", "1", true, false )
CV_MusicVolume = CreateClientConVar( "cl_regmod_musicvolume", "100", true, false )
CV_EnableContent = CreateClientConVar( "cl_regmod_contentmsgs", "1", true, false )

CammeraSmoothness = 10
surface.CreateFont("CSSelectIcons", {
	font = "csd",
	size = ScreenScale(60)
})
local whiteMat = Material( "white_outline" );

//surface.CreateFont("csd", ScreenScale(60), 500, true, true, "CSSelectIcons")
local Player = FindMetaTable("Player")


function GM:PostDrawViewModel( vm, ply, weapon )

	if ( weapon.UseHands || !weapon:IsScripted() ) then

		local hands = LocalPlayer():GetHands()
		if ( IsValid( hands ) ) then hands:DrawModel() end

	end

end


function GM:PostDrawOpaqueRenderables()
/*
	local localP = LocalPlayer();
	for _,client in pairs( player.GetAll() ) do
		if( client ~= localP ) then
			local pos = client:LocalToWorld( client:OBBCenter() );
			local eyePos = EyePos();
			local tAng = ( pos - eyePos )

			local trace = util.QuickTrace( eyePos, tAng );
			local health = client:Health();

			local r = 1 - math.cos( health );
			local g = math.cos( health );
			local pR = 255 / ( r * 255 );
			local pG = 255 / ( g * 255 );

			local b = 0;
			if( trace.HitWorld ) then
				cam.Start3D( EyePos(), EyeAngles() );
					cam.IgnoreZ( true );
						render.SuppressEngineLighting( true );
							render.SetAmbientLight( 1, 1, 1 );
							render.SetColorModulation( pR, pG, b );
							render.MaterialOverride( whiteMat );
								--client:SetModelScale( 1.2 );
									client:DrawModel();
								--client:SetModelScale( 1 );
							render.SetColorModulation( 1, 1, 1 );
						render.SuppressEngineLighting( false )
						--client:DrawModel();
					cam.IgnoreZ( false );
				cam.End3D();
			end;
		end;
	end;
*/

	DrawLaser()

end;

DotMat = Material( "sprites/light_glow02_add_noz" )
LasMat = Material( "sprites/bluelaser1" )

function DrawLaser()

	local wep = LocalPlayer():GetActiveWeapon()

	if not IsValid( wep ) then return end


	if wep.IronSightsPos then
		--if not wep:GetIronsights() then return end
	end

	local look = LocalPlayer():EyeAngles()
	local dir = look:Forward()

	local trace = {}

	trace.start = LocalPlayer():GetShootPos()
	trace.endpos = trace.start + dir * 9000
	trace.filter = { LocalPlayer(), weap, lp }
	trace.mask = MASK_SOLID

	local tr = util.TraceLine( trace )
	local dist = math.Clamp( tr.HitPos:Distance( EyePos() ), 0, 500 )
	local size = math.Rand( 4, 6 ) + ( dist / 500 ) * 7
	local col = Color( CV_LaserRed:GetInt(), CV_LaserGreen:GetInt(), CV_LaserBlue:GetInt(), 255 )

	cam.Start3D( EyePos(), EyeAngles() )

		local norm = ( EyePos() - tr.HitPos ):GetNormal()

		render.SetMaterial( DotMat )
		render.DrawQuadEasy( tr.HitPos + norm * size, norm, size, size, col, 0 )

	cam.End3D()

end

Inventory = {	{Item = 0, Amount = 0},	{Item = 0, Amount = 0},	{Item = 0, Amount = 0},	{Item = 0, Amount = 0},	{Item = 0, Amount = 0},	{Item = 0, Amount = 0}	}
GM.EquippedPerks = { 0, 0, 0 }
GM.OwnedPerks = {}
GM.Chest = {}
GM.Upgrade = {}
GM.OwnedModels = {}
GM.EquippedModel = 0
GM.EquippedModelPath = ""
GM.AttackSkillPoints = 0
GM.HealthSkillPoints = 0
GM.PlayerChestSlots = GM.Config.InitialStorageSlots

function GM:Initialize()
	justjoined = false
	timer.Simple(0.001,function() RunConsoleCommand("InvUpdate") end)
	local FilePath = "re2/music.txt"
	if file.Exists(FilePath, "DATA") then

	local tempcross = util.KeyValuesToTable(file.Read(FilePath))
		tempcross["Music"] = tonumber(file.Read(FilePath))

	else
	  print("Music Not Loaded ")
	end

	timer.Simple(15,function() Sound_Create(GetGlobalString("Music")) end)

end

function StopSounds ( UMsg )
	local Cmd = UMsg:ReadString();
	RunConsoleCommand("stopsounds")
end
usermessage.Hook('StopSounds_re', StopSounds);

function GM:OnContextMenuOpen()

	if not LocalPlayer().CamSwap then LocalPlayer().CamSwap = false end
	LocalPlayer().CamSwap = !LocalPlayer().CamSwap

end

function GM:OnSpawnMenuOpen()
	MENU:OpenInventory()
	LocalPlayer():EmitSound("residentevil/select_re.mp3",100,100)
end

function GM:OnSpawnMenuClose()
	MENU:CloseInventory()
	LocalPlayer():EmitSound("residentevil/cancel_re.mp3",100,100)
end

function GM:Think()

end

function SendDataToServer()
	net.Start("VoteTransfer")
		net.WriteTable{ VoteOption["Map"], VoteOption["Game"],VoteOption["Difficulty"],VoteOption["PrepTime"]  }
	net.SendToServer()
end
concommand.Add("VoteUpdate",SendDataToServer)

Ammoref = {}
Ammoref["item_pammo"] = "pistol"
Ammoref["item_3ammo"] = "357"
Ammoref["item_rammo"] = "ar2"
Ammoref["item_mammo"] = "smg1"
Ammoref["item_bammo"] = "buckshot"

function GM:PlayerBindPress( ply, bind )



	if MENU.Inventory then
		if bind:StartWith( "slot" ) then
			local slot = tonumber( bind:sub( 5 ) )
			if Inventory[ slot ].Item == 0 then return end
			local data = item.GetItem( Inventory[ slot ].Item )
			net.Start( "REGmod.UseItem" )
				net.WriteString( data.ClassName, 32 )
				net.WriteInt( slot, 32 )
			net.SendToServer()
			return true
		end
	end

end

--[[
hook.Add( "Think", "wOS.EnsureProperLoading", function()
	LocalPlayer():ConCommand( "regmod_load" )
	hook.Remove( "Think", "wOS.EnsureProperLoading" )
end )
]]--

---------------------------------
----------------------------------
-----------------------------------
------------------------------------
---------------------------------
---------------------------------
------------------------------------
---------------------------------
----------------------------------
-----------------------------------
------------------------------------
---------------------------------
---------------------------------
------------------------------------
---------------------------------
----------------------------------
-----------------------------------
------------------------------------
---------------------------------
---------------------------------
------------------------------------
---------------------------------
----------------------------------
-----------------------------------
------------------------------------
---------------------------------
---------------------------------
------------------------------------
-----------------------------------------------------------------f4 men


--------------------------------
---------------------------------
----------------------------------
-----------------------------------
------------------------------------
---------------------------------
---------------------------------
------------------------------------
---------------------------------
----------------------------------
-----------------------------------
------------------------------------
---------------------------------
---------------------------------
------------------------------------
---------------------------------
----------------------------------
-----------------------------------
------------------------------------
---------------------------------
---------------------------------
------------------------------------
---------------------------------
----------------------------------
-----------------------------------
------------------------------------
---------------------------------
---------------------------------
------------------------------------
---------------------------------
----------------------------------
-----------------------------------
------------------------------------
---------------------------------
---------------------------------
-----------------------------------
