local w,h = ScrW(), ScrH()

local maincolor = Color( 125, 0, 0, 225 )

if not MENU then MENU = {} end

function MENU:LeaderBoardsMenu()
	
	if GAMEMODE.InMenu and not self.LeaderBoards then return end
	
	if self.LeaderBoards then
		self.LeaderBoards:Remove()
		self.LeaderBoards = nil
		gui.EnableScreenClicker( false )
		GAMEMODE.InMenu = false
		return
	end
	gui.EnableScreenClicker( true )
	GAMEMODE.InMenu = true
	self.LeaderBoards = vgui.Create("DPanel")
	self.LeaderBoards:SetSize( w*0.25, h*0.4 )
	self.LeaderBoards:SetPos( w*0.5, h*0.3 )
	self.LeaderBoards:Center()
	self.LeaderBoards.Paint = function( pan, ww, hh )
		MENU:LargeStencilCut( ww, hh )
			surface.SetDrawColor( maincolor )	
			surface.DrawRect( 0, 0, ww, hh )
		MENU:EndStencil()
		draw.SimpleTextOutlined( "LeaderBoards", "wOS.GenericLarge", ww/2, hh*0.1, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 0, color_white )
		surface.SetFont( "wOS.GenericLarge" )
		local tx, ty = surface.GetTextSize( "LeaderBoards" )
		surface.SetDrawColor( color_white )
		surface.DrawLine( ww/2 - tx/2, hh*0.1, ww/2 + tx/2, hh*0.1 )
	end

	local mw, mh = self.LeaderBoards:GetSize()

	------------------------------------------Leader Boards MENU

	local ply = LocalPlayer()

	local LeaderBoardExperience = vgui.Create( "DLabel", self.LeaderBoards )
	local ldrxpppoints = file.Read( "re2/leaderboards/leaderboards.txt", "DATA" )
	LeaderBoardExperience:SetSize( mw, mh )
	LeaderBoardExperience:SetText( "" )
	LeaderBoardExperience.Paint = function( pan, ww, hh )
		draw.SimpleTextOutlined( "Leaderboards are not finished yet", "wOS.GenericMed", ww*0.5, hh*0.2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
	end


	local PlayersExperience = vgui.Create( "DLabel", self.LeaderBoards )
	local xppoints = ply:GetNWInt("Experience")
	PlayersExperience:SetSize( mw, mh )
	PlayersExperience:SetText( "" )
	PlayersExperience.Paint = function( pan, ww, hh )
		draw.SimpleTextOutlined( "You Have "..xppoints.." Experience", "wOS.GenericMed", ww*0.5, hh*0.7, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
	end

	local PlayersGamesPlayed = vgui.Create( "DLabel", self.LeaderBoards )
	local gamesplayed = ply:GetNWInt("GamesPlayed")
	PlayersGamesPlayed:SetSize( mw, mh )
	PlayersGamesPlayed:SetText( "" )
	PlayersGamesPlayed.Paint = function( pan, ww, hh )
		draw.SimpleTextOutlined( "You played "..gamesplayed.." Games", "wOS.GenericMed", ww*0.5, hh*0.75, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
	end

	local PlayersLevel = vgui.Create( "DLabel", self.LeaderBoards )
	local playerlevel = ply:GetNWInt("Level")
	PlayersLevel:SetSize( mw, mh )
	PlayersLevel:SetText( "" )
	PlayersLevel.Paint = function( pan, ww, hh )
		draw.SimpleTextOutlined( "You Are Level "..playerlevel.."", "wOS.GenericMed", ww*0.5, hh*0.8, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
	end

	




	--------------------------------
	local closebutt = vgui.Create( "DButton", self.LeaderBoards )
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
		self.LeaderBoards:Remove()
		self.LeaderBoards = nil
		gui.EnableScreenClicker( false )
		GAMEMODE.InMenu = false
	end		
	
end