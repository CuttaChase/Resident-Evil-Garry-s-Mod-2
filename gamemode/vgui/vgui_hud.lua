function GM:HUDShouldDraw(Name)
	if Name == "CHudHealth" or Name == "CHudBattery" or Name =="CHudSecondaryAmmo" or Name == "CHudAmmo" then
		return false
	end
	return true
end
local EkgTable = {}
EkgTable[1] = Material("re2_ekg/fine01")
EkgTable[2] = Material("re2_ekg/fine_yellow01")
EkgTable[3] = Material("re2_ekg/caution03")
EkgTable[4] = Material("re2_ekg/danger02")

surface.CreateFont( "zgTimerText", {
 font = "HUDNumber5",
 size = 24,
 weight = 300,
 blursize = 0,
 scanlines = 0,
 antialias = true,
 underline = false,
 italic = false,
 strikeout = false,
 symbol = false,
 rotary = false,
 shadow = false,
 additive = false,
 outline = true
} )

surface.CreateFont( "BigTrebuchet", {
	font = "Trebuchet24o", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	size = 48,
	weight = 700,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = true,
} )

surface.CreateFont( "Trebuchet24o", {
	font = "Trebuchet24", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	size = 24,
	weight = 700,
	blursize = 0,
	scanlines = 0,
	antialias = false,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = true,
} )

surface.CreateFont( "Trebuchet18o", {
	font = "Trebuchet18", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	size = 12,
	weight = 800,
	blursize = 0,
	scanlines = 0,
	antialias = false,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = true,
} )

local gradient = Material("gui/gradient")

function getTextSize(text, font)
	surface.SetFont(font or "Arial")
	return surface.GetTextSize(text)
end

function paintText(text, font, xPos, yPos, col, centerX, centerY)
	surface.SetTextColor(col or Color(255,255,255,255))
	surface.SetFont(font or "Arial")
	local wide, tall = surface.GetTextSize(text)
	if centerX then
		xPos = xPos - wide/2
	end
	if centerY then
		yPos = yPos - tall/2
	end
	surface.SetTextPos(xPos, yPos)
	surface.DrawText(text or "No Text Assigned")
	return wide, tall
end

function GM:HUDPaint()
	--if 1 == 1 then return end
	local SW = ScrW()
	local SH = ScrH()
	local client = LocalPlayer()
	local Money = client:GetNWInt("Money")

	if client:GetActiveWeapon():IsValid() then
		if client:Alive() then
			if client:Team() == TEAM_HUNK then
			local intAmmoInMag = client:GetActiveWeapon():Clip1()
			local intAmmoOutMag = client:GetAmmoCount(client:GetActiveWeapon():GetPrimaryAmmoType())
			local secondary_ammo = client:GetAmmoCount(client:GetActiveWeapon():GetSecondaryAmmoType())
			local MHp = client:GetMaxHealth()
			local Hp = client:Health()
			local str_status = "Fine"
			local Col_Hp = Color(0,255,0,155)
			local ekg = 1
			if Hp >= 75 then
				str_status = "Fine"
				Col_Hp = Color(0,155,0,155)
				ekg = 1
				elseif Hp >= 51 and Hp <= 74 then
				str_status = "Fine"
				ekg = 2
				Col_Hp = Color(155,155,0,155)
				elseif Hp >= 20 and Hp <= 50 then
				str_status = "Caution"
				ekg = 3
				Col_Hp = Color(155,100,0,155)
				elseif Hp <= 19 then
				str_status = "Danger"
				ekg = 4
				Col_Hp = Color(155,0,0,155)
				else
				str_status = "Dead"
				Col_Hp = Color(0,0,0,155)
			end


			local offset = 20
			local offsetY = SH/8 + 20
			surface.SetDrawColor( Col_Hp )

			--- infection
			surface.DrawRect(offset,SH - offsetY, SW/6,SH/8)
			if client:GetNWBool("Infected") then
				surface.SetDrawColor( 111, 152, 49, 100 )
				surface.DrawRect(offset, SH - offsetY, SW/6 * (client:GetNWInt("InfectedPercent")/100), SH/8 )
				draw.SimpleText(client:GetNWInt("InfectedPercent").."%","Trebuchet18o",offset + SW/6 * (client:GetNWInt("InfectedPercent")/100),SH - offsetY/2,Color(255,255,255),1,1)
			end

			surface.SetDrawColor( Color(0,0,0,155))
			surface.DrawLine(offset,SH - offsetY + SH/8 * (1/4),offset + SW/6,SH - offsetY + SH/8 * (1/4))
			surface.DrawLine(offset,SH - offsetY + SH/8 * (2/4),offset + SW/6,SH - offsetY + SH/8 * (2/4))
			surface.DrawLine(offset,SH - offsetY + SH/8 * (3/4),offset + SW/6,SH - offsetY + SH/8 * (3/4))
			surface.DrawOutlinedRect( offset,SH - offsetY, SW/6,SH/8)

			surface.SetDrawColor( Color(0,155,0,155) )
			surface.SetMaterial( EkgTable[ekg] )
			surface.DrawTexturedRect( offset,SH - offsetY, SW/6,SH/8)

	----------------Ammo

			paintText(translate.Format("mags_x_format", intAmmoInMag),"Trebuchet18o",5,87,Color(200,200,200,255),false,false)
			paintText(translate.Format("ammo_x_format", intAmmoOutMag),"Trebuchet18o",5,102,Color(200,200,200,255),false,false)
			--..
			paintText(translate.Format("kills_x_format", client:GetNWInt("killcount")),"Trebuchet18o",5,72,Color(200,200,200,255),false,false)
			paintText(translate.Format("money_x_format2", string.Comma(Money)), "Trebuchet24o", 5, 0, Color(0,255,0,255), false, false)

			--if GetGlobalBool("Re2_Classic") then
				--draw.SimpleText("Classic","Default",58,SH-60,Color(155,0,0,255),0,0)
			--end

			if GAMEMODE.Gamemode[GetGlobalString("RE2_Game")].Name != nil then
				paintText(translate.Format("game_format_name", translate.Get("gametype_" .. string.lower(GAMEMODE.Gamemode[GetGlobalString("RE2_Game")].Name))),"Trebuchet18o",5,56,Color(255,255,255,255),false,false)
			else
				paintText(translate.Format("game_format_name", translate.Get("gametype_" .. string.lower(GetGlobalString("RE2_Game")))),"Trebuchet18o",5,56,Color(200,200,200,255),false,false)
			end
				paintText(translate.Format("difficulty_format_name", translate.Get("difficulty_name_" .. string.lower(GetGlobalString("RE2_Difficulty")))),"Trebuchet18o",5,40,Color(200,200,200,255),false,false)
				local xPos, yPos = ScrW()/2, 0
				local text = ""
				if GetGlobalString("Mode") == "Merchant" || GetGlobalString("Mode") == "prep" then
					text = translate.Format("starting_in_x_format", string.ToMinutesSeconds(GetGlobalInt("Re2_CountDown")))
				elseif GetGlobalString("Mode") == "On" && GetGlobalString("RE2_Game") != "Mercenaries" && GetGlobalString("RE2_Game") != "VIP" && GetGlobalString("RE2_Game") != "TeamVIP" && GetGlobalString("RE2_Game") != "Boss" then
					text = translate.Format("time_alive_x_format", string.ToMinutesSeconds(client:GetNWInt("Time")))
					//draw.SimpleText(translate.Format("time_alive_x_format", string.ToMinutesSeconds(client:GetNWInt("Time"))),"Trebuchet18o",5,SH-25.6,Color(255,255,255,255),0,0)
				elseif GetGlobalString("Mode") == "On" && GetGlobalString("RE2_Game") == "Mercenaries" || GetGlobalString("RE2_Game") == "VIP" ||  GetGlobalString("RE2_Game") == "TeamVIP" ||  GetGlobalString("RE2_Game") == "Boss"  then
					text = translate.Format("time_alive_x_format", string.ToMinutesSeconds(GetGlobalInt("Re2_CountDown")))
					//draw.SimpleText(translate.Format("time_left_x_format", string.ToMinutesSeconds(GetGlobalInt("Re2_CountDown"))),"Trebuchet18o",5,SH-25.6,Color(255,255,255,255),0,0)
				end
				local width, height = getTextSize(text, "zgTimerText")
				height = height + 5
				width = ScrW() * (1/3)

				surface.SetDrawColor(0,0,0,255)

				surface.SetMaterial( gradient )
				surface.DrawTexturedRectRotated( xPos - width/2, yPos + height/2, width, height - 1, 180)

				surface.SetMaterial( gradient )
				surface.DrawTexturedRectRotated( xPos + width/2 - 1, yPos + height/2, width, height, 0)

				paintText(text, "zgTimerText", xPos, yPos + height/2, Color(255,255,255,155), true, true)

				if GetGlobalString("RE2_Game") == "Survivor" or GetGlobalString("RE2_Game") == "Doom" then
					paintText(translate.Format("dead_zombies_format", GetGlobalInt("RE2_DeadZombies"), GetGlobalInt("DeadZombieKillNumber")),"Trebuchet18o",5,24,Color(200,10,10,255),false,false)
				else
					paintText(translate.Format("dead_zombies_format2", GetGlobalInt("RE2_DeadZombies")),"Trebuchet18o",5,24,Color(200,10,10,255),false,false)
				end
				paintText(translate.Format("condition_format_status", translate.Get("status_" .. string.lower(str_status))),"Trebuchet24o",offset,SH - SH/6,Color(255,255,255,255),false,true)
			end
		end
	end
		--Spectators
	if client:Team() == TEAM_SPECTATOR or client:Team() == TEAM_CROWS then
			surface.SetDrawColor( Color(90,90,90,155))
			surface.DrawRect(0,SH - 158 ,128,158)

			surface.SetDrawColor( Color(0,0,0,200))
			surface.DrawOutlinedRect(0,SH -158,129,159)

			draw.SimpleText(translate.Format("difficulty_format_name", translate.Get("difficulty_name_" .. string.lower(GetGlobalString("RE2_Difficulty")))),"Trebuchet18o",5,SH-144,Color(255,255,255,255),0,0)
			draw.SimpleText(translate.Format("your_kills_x_format", client:GetNWInt("killcount")),"Trebuchet18o",5,SH-100,Color(200,200,200,255),0,0)
			draw.SimpleText(translate.Format("money_x_format", Money),"Trebuchet18o",5,SH-80,Color(50,200,50,255),0,0)
			if GAMEMODE.Gamemode[GetGlobalString("RE2_Game")].Name != nil then
				draw.SimpleText(translate.Format("game_format_name", translate.Get("gametype_" .. string.lower(GAMEMODE.Gamemode[GetGlobalString("RE2_Game")].Name))),"Trebuchet18o",5,SH-60,Color(255,255,255,255),0,0)
			else
				draw.SimpleText(translate.Format("game_format_name", translate.Get("gametype_" .. string.lower(GetGlobalString("RE2_Game")))),"Trebuchet18o",5,SH-60,Color(255,255,255,255),0,0)
			end
			draw.SimpleText(translate.Format("your_time_x_format", string.ToMinutesSeconds(client:GetNWInt("Time"))),"Trebuchet18o",5,SH-40,Color(255,255,255,255),0,0)

				if GetGlobalString("Mode") == "Merchant" || GetGlobalString("Mode") == "prep" then
					draw.SimpleText(translate.Format("starting_in_x_format", string.ToMinutesSeconds(GetGlobalInt("Re2_CountDown"))),"Trebuchet18o",5,SH-20,Color(255,255,255),0,0)
				elseif GetGlobalString("Mode") == "On" && GetGlobalString("RE2_Game") != "Mercenaries" && GetGlobalString("RE2_Game") != "VIP" && GetGlobalString("RE2_Game") != "TeamVIP" && GetGlobalString("RE2_Game") != "Boss"  then
					draw.SimpleText(translate.Format("gametime_x_format", string.ToMinutesSeconds(GetGlobalInt("Re2_GameTime"))),"Trebuchet18o",5,SH-20,Color(255,255,255,255),0,0)
				elseif GetGlobalString("Mode") == "On" && GetGlobalString("RE2_Game") == "Mercenaries" || GetGlobalString("RE2_Game") == "VIP" ||  GetGlobalString("RE2_Game") == "TeamVIP" ||  GetGlobalString("RE2_Game") == "Boss" then
					draw.SimpleText(translate.Format("time_left_x_format", string.ToMinutesSeconds(GetGlobalInt("Re2_CountDown"))),"Trebuchet18o",5,SH-20,Color(255,255,255,255),0,0)
				end
				if GetGlobalString("RE2_Game") == "Survivor" or GetGlobalString("RE2_Game") == "Doom" then
					draw.SimpleText(translate.Get("dead_zombies_format3"),"Trebuchet18o",5,SH-124,Color(200,10,10),0,0)
					draw.SimpleText(translate.Format("dead_zombies_format4", GetGlobalInt("RE2_DeadZombies"), GetGlobalInt("DeadZombieKillNumber")),"Trebuchet18o", 64 ,SH-112,Color(200,10,10),1,0)
				else
					draw.SimpleText(translate.Get("dead_zombies_format3"),"Trebuchet18o", 5,SH-124,Color(200,10,10),0,0)
					draw.SimpleText(GetGlobalInt("RE2_DeadZombies"),"Trebuchet18o", 64,SH-112,Color(200,10,10),1,0)
				end
	end


	if GAMEMODE.Gamemode[GetGlobalString("RE2_Game")] != nil then
		if GAMEMODE.Gamemode[GetGlobalString("RE2_Game")].HudFunction != nil then
			GAMEMODE.Gamemode[GetGlobalString("RE2_Game")].HudFunction(client)
		end
	end
end

function DrawIcon( TextureId, Left, Top, Width, Height)
	surface.SetTexture( TextureId )
	surface.SetDrawColor(255,255,255,255)
	surface.DrawTexturedRect( Left, Top, Width, Height )
end

local temptable = {}
table.Merge(temptable,itemtypes)
table.Merge(temptable,weapontypes)

hook.Add( "PreDrawHalos", "HighlightItems", function()
	local desireditem = {}
	local tr = util.GetPlayerTrace(LocalPlayer(),LocalPlayer():GetAimVector())
 	local trace = util.TraceLine(tr)
	local ent = Entity(trace.Entity:EntIndex())
	local entclass = ent:GetClass()
	local distance = LocalPlayer():GetPos():Distance(ent:GetPos())
 	if !trace.Hit then return end
 	if !trace.HitNonWorld then return end
	if !temptable[entclass] then return end  --searchers all item_ ents
	if distance > 80.0 then return end   --set the render distance
	table.insert(desireditem,ent)
	halo.Add( desireditem, Color( 255, 0, 0 ), 6, 10, 1 )
end )

hook.Add("PostDrawHUD","ItemsText",function()

	local tr = util.GetPlayerTrace(LocalPlayer(),LocalPlayer():GetAimVector())
 	local trace = util.TraceLine(tr)
 	if !trace.Hit then return end
 	if !trace.HitNonWorld then return end
	local ent = Entity(trace.Entity:EntIndex())
	local entclass = ent:GetClass()
	local distance = LocalPlayer():GetPos():Distance(ent:GetPos())
	if distance > 80.0 then return end
			text = temptable[entclass]
			if text !=nil then
			draw.SimpleText(translate.Get("target_item_name_" .. string.lower(text)), "Trebuchet24", ScrW()/2, ScrH()/2*1.04, Color(255,255,255,130), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

end)


hook.Add( "PostDrawHUD", "ZombieHUD", function()
	local tr = util.GetPlayerTrace(LocalPlayer(),LocalPlayer():GetAimVector())
 	local trace = util.TraceLine(tr)
 	if !trace.Hit then return end
 	if !trace.HitNonWorld then return end
	local ent = Entity(trace.Entity:EntIndex())
	local entclass = ent:GetClass()
	local distance = LocalPlayer():GetPos():Distance(ent:GetPos())
	local alpha = math.Clamp( 90 - distance / 750 * 100, 0, 255 );
	if distance > 750 then return end
	local ZHealth = Color(100,255,100,alpha)
	if ent:Health() >= 75 then
		ZHealth = Color(0,155,0,alpha)
	elseif ent:Health() >= 51 and trace.Entity:Health() <= 74 then
		ZHealth = Color(155,155,0,alpha)
	elseif ent:Health() >= 20 and trace.Entity:Health() <= 50 then
		ZHealth = Color(155,100,0,alpha)
	elseif ent:Health() <= 19 then
		ZHealth = Color(155,0,0,alpha)
	end
		zname = zombtable[entclass]
		if zname !=nil then
			surface.SetDrawColor(ZHealth)
			surface.DrawRect(ScrW()/2-50,ScrH()/2 *1.1,100,10)
			surface.SetDrawColor(50,50,50,alpha)
			surface.DrawOutlinedRect(ScrW()/2-50,ScrH()/2 *1.1,100,10)

			surface.SetDrawColor(255,25,255,255)
			surface.SetFont("Default")
			draw.SimpleText( translate.Get("target_monster_name_" .. string.lower(zname)), "TargetIDSmall", ScrW()/2, ScrH()/2*1.085, ZHealth,TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
end )

hook.Add("HUDPaint","PlayersHUD",function()
	local tr = util.GetPlayerTrace(LocalPlayer(),LocalPlayer():GetAimVector())
	local trace = util.TraceLine(tr)
	if !trace.Hit then return end
	if !trace.HitNonWorld then return end
	local ent = Entity(trace.Entity:EntIndex())
	local entclass = ent:GetClass()
	local distance = LocalPlayer():GetPos():Distance(ent:GetPos())
	local alpha = math.Clamp( 110 - distance / 400 * 100, 0, 255 );
	if distance > 400 then return end
	local Hpcolor = Color(0,155,0,alpha)

	if ent:Health() >= 75 then
		Hpcolor = Color(0,155,0,alpha)
	elseif ent:Health() >= 51 and trace.Entity:Health() <= 74 then
		Hpcolor = Color(155,155,0,alpha)
	elseif ent:Health() >= 20 and trace.Entity:Health() <= 50 then
		Hpcolor = Color(155,100,0,alpha)
	elseif ent:Health() <= 19 then
		Hpcolor = Color(155,0,0,alpha)
	end

	if trace.Entity:GetClass() == "player" then
		surface.SetDrawColor(Hpcolor)
		surface.DrawRect(ScrW()/2-50,ScrH()/2 *1.1,100,10)
		surface.SetDrawColor(50,50,50,alpha)
		surface.DrawOutlinedRect(ScrW()/2-50,ScrH()/2 *1.1,100,10)
		surface.SetDrawColor(50,50,50,alpha)
		if trace.Entity:GetNWBool("Infected") then
			surface.SetDrawColor(50,50,50,alpha)
			surface.DrawRect(ScrW()/2-50,ScrH()/2 *1.13,100,10)
			surface.SetDrawColor( 111, 152, 49, alpha )
			surface.DrawRect(ScrW()/2-50,ScrH()/2 *1.13,trace.Entity:GetNWInt("InfectedPercent"),10)
			surface.SetDrawColor(0,0,0,alpha)
			surface.SetFont("Default")
		end
		surface.SetDrawColor(255,25,255,255)
		surface.SetFont("Default")
		local x,y = surface.GetTextSize(trace.Entity:Nick())
		surface.SetTextPos(ScrW()/2-x/2,ScrH()/2 + 200)
		draw.SimpleText( ent:Nick(), "Trebuchet24", ScrW()/2, ScrH()/2*1.08, Color(0,100,0,alpha),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end

end)
