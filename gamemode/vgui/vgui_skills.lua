local w,h = ScrW(), ScrH()

local maincolor = Color( 125, 0, 0, 225 )

if not MENU then MENU = {} end

function MENU:SkillsMenu()
	
	if GAMEMODE.InMenu and not self.Skills then return end
	
	if self.Skills then
		self.Skills:Remove()
		self.Skills = nil
		gui.EnableScreenClicker( false )
		GAMEMODE.InMenu = false
		return
	end
	gui.EnableScreenClicker( true )
	GAMEMODE.InMenu = true
	self.Skills = vgui.Create("DPanel")
	self.Skills:SetSize( w*0.25, h*0.4 )
	self.Skills:SetPos( w*0.5, h*0.3 )
	self.Skills:Center()
	self.Skills.Paint = function( pan, ww, hh )
		MENU:LargeStencilCut( ww, hh )
			surface.SetDrawColor( maincolor )	
			surface.DrawRect( 0, 0, ww, hh )
		MENU:EndStencil()
		draw.SimpleTextOutlined( "Skills", "wOS.GenericLarge", ww/2, hh*0.1, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 0, color_white )
		surface.SetFont( "wOS.GenericLarge" )
		local tx, ty = surface.GetTextSize( "Skills" )
		surface.SetDrawColor( color_white )
		surface.DrawLine( ww/2 - tx/2, hh*0.1, ww/2 + tx/2, hh*0.1 )
	end

	local mw, mh = self.Skills:GetSize()

	------------------------------------------Skills MENU

	local ply = LocalPlayer()

	local points = ply:GetNWInt("SkillPoints")

	local SkillsRemaining = vgui.Create( "DLabel", self.Skills )
	
	
	--
	SkillsRemaining:SetText( "You Have "..points.." Points" )
	SkillsRemaining:SetFont( "wOS.GenericMed" )
	SkillsRemaining:CenterHorizontal(0.41)
	SkillsRemaining:CenterVertical( -0.28 )
	SkillsRemaining:SetSize( mw, mh )
	
	
	
	
	--draw.SimpleTextOutlined( ""..points.." Points", "wOS.GenericMed", mw/2, mh/1.2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )

	-------------------------------------------------

	local AttackPower = vgui.Create( "DButton", self.Skills)
	AttackPower:SetSize( mw*0.4, mh*0.2 )
	AttackPower:SetPos( mw*0.05, mh*0.24 )
	AttackPower:SetText( "" )
	AttackPower.Paint = function( pan, ww, hh )
		MENU:StencilCut( ww, hh )
			surface.SetDrawColor( Color( 0, 0, 0, 175 ) )
			surface.DrawRect( 0, 0, ww, hh )
		MENU:EndStencil()
		
		draw.SimpleTextOutlined( "AttackPower", "wOS.GenericMed", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		local attackpoints = LocalPlayer():GetNWInt("AttackPoints")
		if attackpoints < 50 then
			draw.SimpleTextOutlined( attackpoints, "Trebuchet18", ww/2, hh/2+20, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		else
			draw.SimpleTextOutlined( "Max", "Trebuchet18", ww/2, hh/2+20, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		end
	end
	AttackPower.DoClick = function( pan )
		local attackpoints = LocalPlayer():GetNWInt("AttackPoints")
		if attackpoints < 50 then
			surface.PlaySound( "buttons/button14.wav" )
		-------------------------------------------
			net.Start("REGmod.AttackPower")
			net.SendToServer()
		else
			LocalPlayer():PrintMessage(HUD_PRINTCENTER,"Max Attack Power")
		end
	end

	------------------------------------------------

	local HealthUp = vgui.Create( "DButton", self.Skills)
	HealthUp:SetSize( mw*0.4, mh*0.2 )
	HealthUp:SetPos( mw*0.05, mh*0.46 )
	HealthUp:SetText( "" )
	HealthUp.Paint = function( pan, ww, hh )
		MENU:StencilCut( ww, hh )
			surface.SetDrawColor( Color( 0, 0, 0, 175 ) )
			surface.DrawRect( 0, 0, ww, hh )
		MENU:EndStencil()
		local healthpoints = LocalPlayer():GetNWInt("HealthPoints")
		draw.SimpleTextOutlined( "HealthUp", "wOS.GenericMed", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		if healthpoints < 150 then
			draw.SimpleTextOutlined( healthpoints, "Trebuchet18", ww/2, hh/2+20, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		else
			draw.SimpleTextOutlined( "Max", "Trebuchet18", ww/2, hh/2+20, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		end
	end
	HealthUp.DoClick = function( pan )
		local healthpoints = LocalPlayer():GetNWInt("HealthPoints")
		if healthpoints < 150 then
			surface.PlaySound( "buttons/button14.wav" )

			-------------------------------------------

			net.Start("REGmod.HealthUp")
			net.SendToServer()
		else
			LocalPlayer():PrintMessage(HUD_PRINTCENTER,"Max Health Up")
		end
	end



	------------------------------------------------

	local AmmoUp = vgui.Create( "DButton", self.Skills)
	AmmoUp:SetSize( mw*0.4, mh*0.2 )
	AmmoUp:SetPos( mw*0.55, mh*0.24 )
	AmmoUp:SetText( "" )
	AmmoUp.Paint = function( pan, ww, hh )
		MENU:StencilCut( ww, hh )
			surface.SetDrawColor( Color( 0, 0, 0, 175 ) )
			surface.DrawRect( 0, 0, ww, hh )
		MENU:EndStencil()
		local ammopoints = LocalPlayer():GetNWInt("AmmoRegenPoints")
		draw.SimpleTextOutlined( "Ammo Regen", "wOS.GenericMed", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		if ammopoints < 75 then
			draw.SimpleTextOutlined( ammopoints, "Trebuchet18", ww/2, hh/2+20, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		else
			draw.SimpleTextOutlined( "Max", "Trebuchet18", ww/2, hh/2+20, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		end
	end
	AmmoUp.DoClick = function( pan )
		local ammopoints = LocalPlayer():GetNWInt("AmmoRegenPoints")
		if ammopoints < 75 then
			surface.PlaySound( "buttons/button14.wav" )
		--LocalPlayer():ChatPrint("This is not done yet")

		-------------------------------------------
		
			net.Start("REGmod.AmmoRegen")
			net.SendToServer()
		else
			LocalPlayer():PrintMessage(HUD_PRINTCENTER,"Max Ammo Regen")
		end
	end


	------------------Show Stats with skills-----------

	local HealthUpStat = vgui.Create( "DLabel", self.Skills )
	local hpoints = ply:GetNWInt("HealthPoints")
	local hpointsadjusted = hpoints / 4
	HealthUpStat:SetSize( mw, mh )
	HealthUpStat:SetText( "" )
	HealthUpStat.Paint = function( pan, ww, hh )
		draw.SimpleTextOutlined( "Health Increased by "..hpointsadjusted.."%", "Trebuchet18", ww*0.25, hh*0.79, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
	end

	local AttackUpStat = vgui.Create( "DLabel", self.Skills )
	local apoints = ply:GetNWInt("AttackPoints")
	local apointsadjusted = apoints / 4
	AttackUpStat:SetSize( mw, mh )
	AttackUpStat:SetText( "" )
	AttackUpStat.Paint = function( pan, ww, hh )
		draw.SimpleTextOutlined( "Power Increased by "..apointsadjusted.."%", "Trebuchet18", ww*0.25, hh*0.72, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
	end



	local AmmoUpStat = vgui.Create( "DLabel", self.Skills )
	local ammopoints = ply:GetNWInt("AmmoRegenPoints")
	local ammopointsadjusted = 105 - (ammopoints)
	AmmoUpStat:SetSize( mw, mh )
	AmmoUpStat:SetText( "" )
	AmmoUpStat.Paint = function( pan, ww, hh )
		if ammopoints > 0 then
			draw.SimpleTextOutlined( "AmmoRegen Rate Is "..ammopointsadjusted.." seconds", "Trebuchet18", ww*0.75, hh*0.72, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		else
			draw.SimpleTextOutlined( "No AmmoRegen", "Trebuchet18", ww*0.75, hh*0.72, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		end
	end
	












	--------------------------------
	local closebutt = vgui.Create( "DButton", self.Skills )
	closebutt:SetSize( mw*0.9, mh*0.12 )
	closebutt:SetPos( mw*0.05, mh*0.83 )
	closebutt:SetText( "" )
	closebutt.Paint = function( pan, ww, hh )
		MENU:StencilCut( ww, hh )
			surface.SetDrawColor( Color( 0, 0, 0, 175 ) )	
			surface.DrawRect( 0, 0, ww, hh )
		MENU:EndStencil()
		draw.SimpleTextOutlined( "Close Menu", "wOS.GenericMed", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
	end
	closebutt.DoClick = function( pan )
		surface.PlaySound( "buttons/button14.wav" ) 
		self.Skills:Remove()
		self.Skills = nil
		gui.EnableScreenClicker( false )
		GAMEMODE.InMenu = false
	end		
	
end