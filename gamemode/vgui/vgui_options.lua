local w,h = ScrW(), ScrH()

local maincolor = Color( 125, 0, 0, 225 )

if not MENU then MENU = {} end

function MENU:OptionsMenu()
	
	if GAMEMODE.InMenu and not self.Options then return end
	
	if self.Options then
		self.Options:Remove()
		self.Options = nil
		gui.EnableScreenClicker( false )
		GAMEMODE.InMenu = false
		return
	end
	gui.EnableScreenClicker( true )
	GAMEMODE.InMenu = true
	self.Options = vgui.Create("DPanel")
	self.Options:SetSize( w*0.25, h*0.4 )
	self.Options:SetPos( w*0.5, h*0.3 )
	self.Options.Paint = function( pan, ww, hh )
		MENU:LargeStencilCut( ww, hh )
			surface.SetDrawColor( maincolor )	
			surface.DrawRect( 0, 0, ww, hh )
		MENU:EndStencil()
		draw.SimpleTextOutlined( translate.Get("options_title"), "wOS.GenericLarge", ww/2, hh*0.1, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 0, color_white )
		surface.SetFont( "wOS.GenericLarge" )
		local tx, ty = surface.GetTextSize( translate.Get("options_title") )
		surface.SetDrawColor( color_white )
		surface.DrawLine( ww/2 - tx/2, hh*0.1, ww/2 + tx/2, hh*0.1 )
	end

	local mw, mh = self.Options:GetSize()
	
	local OptionsContent = vgui.Create("DButton", self.Options )
	OptionsContent:SetPos( mw*0.05, mh*0.12 )
	OptionsContent:SetSize( mw*0.9, mh*0.1 )
	OptionsContent:SetText("")
	OptionsContent.Enabled = CV_EnableContent:GetBool()
	OptionsContent.Paint = function( pan, ww, hh )
		MENU:RightStencilCut( ww*0.25, hh )
			surface.SetDrawColor( Color( 255, 0, 0, 175 ) )
			if CV_EnableContent:GetBool() then
				surface.SetDrawColor( Color( 0, 255, 0, 175 ) )
			end
			surface.DrawRect( 0, 0, ww*0.25, hh )
		MENU:EndStencil()
		
		MENU:LeftStencilCut( ww*0.75, hh, ww*0.25 )
			surface.SetDrawColor( Color( 0, 0, 0, 175 ) )
			surface.DrawRect( 0, 0, ww, hh )
		MENU:EndStencil()		

		draw.SimpleTextOutlined( translate.Get("options_enable_content_msgs"), "wOS.GenericMed", ww*0.28, hh/2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, color_white )		
		
	end
	OptionsContent.DoClick = function( pan ) 
		pan.Enabled = !pan.Enabled
		if pan.Enabled then
			LocalPlayer():ConCommand( "cl_regmod_contentmsgs 1" )
		else
			LocalPlayer():ConCommand( "cl_regmod_contentmsgs 0" )		
		end
		surface.PlaySound( "buttons/lightswitch2.wav" ) 
	end
	
	local OptionsMusic = vgui.Create("DButton", self.Options )
	OptionsMusic:SetPos( mw*0.05, mh*0.24 )
	OptionsMusic:SetSize( mw*0.9, mh*0.1 )
	OptionsMusic:SetText("")
	OptionsMusic.Enabled = CV_EnableMusic:GetBool()
	OptionsMusic.Paint = function( pan, ww, hh )
		MENU:RightStencilCut( ww*0.25, hh )
			surface.SetDrawColor( Color( 255, 0, 0, 175 ) )
			if CV_EnableMusic:GetBool() then
				surface.SetDrawColor( Color( 0, 255, 0, 175 ) )
			end
			surface.DrawRect( 0, 0, ww*0.25, hh )
		MENU:EndStencil()
		
		MENU:LeftStencilCut( ww*0.75, hh, ww*0.25 )
			surface.SetDrawColor( Color( 0, 0, 0, 175 ) )
			surface.DrawRect( 0, 0, ww, hh )
		MENU:EndStencil()		

		draw.SimpleTextOutlined( translate.Get("options_enable_music"), "wOS.GenericMed", ww*0.28, hh/2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, color_white )		
	end
	
	OptionsMusic.DoClick = function( pan ) 
		pan.Enabled = !pan.Enabled
		if pan.Enabled then
			Sound_PlayTrack()
			LocalPlayer():ConCommand( "cl_regmod_enablemusic 1" )
		else
			Sound_StopTrack()
			LocalPlayer():ConCommand( "cl_regmod_enablemusic 0" )
		end
		surface.PlaySound( "buttons/lightswitch2.wav" )
	end

	local crp = vgui.Create( "DPanel", self.Options )
	crp:SetPos( mw*0.5, mh*0.4 )
	crp:SetSize( mw*0.45, mh*0.38 )
	crp.Paint = function( pan, ww, hh )
		draw.RoundedBox( 5, 0, 0, ww, hh, Color( 0, 0, 0, 175 ) )
		draw.SimpleTextOutlined( translate.Get("options_laser_color"), "wOS.GenericMed", ww/2, hh*0.2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		surface.SetDrawColor( Color( CV_LaserRed:GetInt(), CV_LaserGreen:GetInt(), CV_LaserBlue:GetInt(), 255 ) )
		surface.SetMaterial( DotMat )
		surface.DrawTexturedRect( ww/4, hh/4, ww/2, hh/2 )
	end
	
	local OptionsMenuCrosshair = vgui.Create( "DColorMixer", self.Options )
	OptionsMenuCrosshair:SetPos( mw*0.05, mh*0.4 )
	OptionsMenuCrosshair:SetSize( mw*0.45, mh*0.38 )
	OptionsMenuCrosshair:SetPalette( false ) 	
	OptionsMenuCrosshair:SetAlphaBar( false )
	OptionsMenuCrosshair:SetWangs( false )		
	OptionsMenuCrosshair:SetColor( Color( CV_LaserRed:GetInt(), CV_LaserGreen:GetInt(), CV_LaserBlue:GetInt(), 255 ) )	--Set the default color
	function OptionsMenuCrosshair:ValueChanged()
		local color = self:GetColor()
		LocalPlayer():ConCommand( "cl_regmod_lasercol_r " .. color.r )
		LocalPlayer():ConCommand( "cl_regmod_lasercol_g " .. color.g )
		LocalPlayer():ConCommand( "cl_regmod_lasercol_b " .. color.b )		
	end

	local closebutt = vgui.Create( "DButton", self.Options )
	closebutt:SetSize( mw*0.9, mh*0.12 )
	closebutt:SetPos( mw*0.05, mh*0.83 )
	closebutt:SetText( "" )
	closebutt.Paint = function( pan, ww, hh )
		MENU:StencilCut( ww, hh )
			surface.SetDrawColor( Color( 0, 0, 0, 175 ) )	
			surface.DrawRect( 0, 0, ww, hh )
		MENU:EndStencil()
		draw.SimpleTextOutlined( translate.Get("options_close_menu"), "wOS.GenericMed", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
	end
	closebutt.DoClick = function( pan )
		surface.PlaySound( "buttons/button14.wav" ) 
		self.Options:Remove()
		self.Options = nil
		gui.EnableScreenClicker( false )
		GAMEMODE.InMenu = false
	end		
	
end









hook.Add( "HUDPaint", "ContentMessages", function()
	if GetConVar("cl_regmod_contentmsgs"):GetBool(1) then
		if LocalPlayer():Team() == TEAM_HUNK then
			draw.DrawText( translate.Get("survivormessage1"), "Trebuchet18", ScrW() * 0.5, ScrH() * 0.7, color_white, TEXT_ALIGN_CENTER )
			draw.DrawText( translate.Get("survivormessage2"), "Trebuchet18", ScrW() * 0.5, ScrH() * 0.7 + 15, color_white, TEXT_ALIGN_CENTER )
			draw.DrawText( translate.Get("survivormessage3"), "Trebuchet18", ScrW() * 0.5, ScrH() * 0.7 + 30, color_white, TEXT_ALIGN_CENTER )
			draw.DrawText( translate.Get("survivormessage4"), "Trebuchet18", ScrW() * 0.5, ScrH() * 0.7 + 45, color_white, TEXT_ALIGN_CENTER )
			draw.DrawText( translate.Get("survivormessage5"), "Trebuchet18", ScrW() * 0.5, ScrH() * 0.7 + 60, color_white, TEXT_ALIGN_CENTER )
		elseif LocalPlayer():Team() == TEAM_CROWS then
			draw.DrawText( translate.Get("crowmessage1"), "Trebuchet18", ScrW() * 0.5, ScrH() * 0.7, color_white, TEXT_ALIGN_CENTER )
			draw.DrawText( translate.Get("crowmessage2"), "Trebuchet18", ScrW() * 0.5, ScrH() * 0.7 + 15, color_white, TEXT_ALIGN_CENTER )
			draw.DrawText( translate.Get("crowmessage3"), "Trebuchet18", ScrW() * 0.5, ScrH() * 0.7 + 30, color_white, TEXT_ALIGN_CENTER )
			draw.DrawText( translate.Get("crowmessage4"), "Trebuchet18", ScrW() * 0.5, ScrH() * 0.7 + 45, color_white, TEXT_ALIGN_CENTER )
			draw.DrawText( translate.Get("crowmessage5"), "Trebuchet18", ScrW() * 0.5, ScrH() * 0.7 + 60, color_white, TEXT_ALIGN_CENTER )
		end
	end
end )