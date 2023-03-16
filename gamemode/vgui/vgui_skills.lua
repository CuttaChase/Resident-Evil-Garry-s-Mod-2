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
	end
	AttackPower.DoClick = function( pan )
		surface.PlaySound( "buttons/button14.wav" )
		
		-------------------------------------------

		net.Start("REGmod.AttackPower")
		net.SendToServer()
	end

	local HealthUp = vgui.Create( "DButton", self.Skills)
	HealthUp:SetSize( mw*0.4, mh*0.2 )
	HealthUp:SetPos( mw*0.05, mh*0.46 )
	HealthUp:SetText( "" )
	HealthUp.Paint = function( pan, ww, hh )
		MENU:StencilCut( ww, hh )
			surface.SetDrawColor( Color( 0, 0, 0, 175 ) )
			surface.DrawRect( 0, 0, ww, hh )
		MENU:EndStencil()
		draw.SimpleTextOutlined( "HealthUp", "wOS.GenericMed", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
	end
	HealthUp.DoClick = function( pan )
		surface.PlaySound( "buttons/button14.wav" )

		-------------------------------------------

		net.Start("REGmod.HealthUp")
		net.SendToServer()
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