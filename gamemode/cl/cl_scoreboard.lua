function GM:GetTeamScoreInfo()
	local TeamInfo = {}
	for id,pl in pairs( player.GetAll() ) do
		local _health = pl:Health()
		local _infection = pl:GetNWInt("InfectedPercent")
		local _infected = pl:GetNWBool("Infected")
		local _team = pl:Team()
		local _frags = pl:GetNWInt("killcount")
		local _deaths = pl:Deaths()
		local _ping = pl:Ping()
		if (not TeamInfo[_team]) then
			TeamInfo[_team] = {}
			TeamInfo[_team].TeamName = team.GetName( _team )
			TeamInfo[_team].Color = team.GetColor( _team )
			TeamInfo[_team].Players = {}
		end
		local PlayerInfo = {}
		PlayerInfo.Frags = _frags
		PlayerInfo.Deaths = _deaths
		if pl:Alive() then
			PlayerInfo.IsAlive = true
		else
			PlayerInfo.IsAlive = false
		end
		PlayerInfo.Money = pl:GetNWInt("Money")
		PlayerInfo.Infected = _infected
		PlayerInfo.InfectedPercent = _infection
		PlayerInfo.Score = _frags - _deaths
		PlayerInfo.Ping = _ping
		PlayerInfo.Name = pl:Nick()
		PlayerInfo.Team = pl:Team()
		PlayerInfo.TeamName = team.GetName(pl:Team())
		PlayerInfo.PlayerObj = pl
		if GAMEMODE.Gamemode[GetGlobalString("Re2_Game")].Teams != nil && GAMEMODE.Gamemode[GetGlobalString("Re2_Game")].Teams then
			PlayerInfo.Re2Team = pl:GetNWInt("TeamId")
		end
		local insertPos = #TeamInfo[_team].Players + 1
		for idx,info in pairs(TeamInfo[_team].Players) do
			if (PlayerInfo.Frags > info.Frags) then
				insertPos = idx
				break
			elseif (PlayerInfo.Frags == info.Frags) then
				if (PlayerInfo.Deaths < info.Deaths) then
					insertPos = idx
					break
				elseif (PlayerInfo.Deaths == info.Deaths) then
					if (PlayerInfo.Name < info.Name) then
						insertPos = idx
						break
					end
				end
			end
		end
		table.insert(TeamInfo[_team].Players, insertPos, PlayerInfo)
	end
	return TeamInfo
end

GM.ShowScoreboard = false

function GM:ScoreboardShow()
	GAMEMODE.ShowScoreboard = true
end

function GM:ScoreboardHide()
	GAMEMODE.ShowScoreboard = false
end

function GM:HUDDrawScoreBoard()

	if (!GAMEMODE.ShowScoreboard) then return end

	if (GAMEMODE.ScoreDesign == nil) then

		GAMEMODE.ScoreDesign = {}
		GAMEMODE.ScoreDesign.HeaderY = 0
		GAMEMODE.ScoreDesign.Height = ScrH() / 2

	end

	local alpha = 255

	local ScoreboardInfo = self:GetTeamScoreInfo()

	local xOffset = 0
	local yOffset = 32
	local scrWidth = ScrW()
	local scrHeight = ScrH() - 64
	local boardWidth = scrWidth - (2* xOffset)
	local boardHeight = scrHeight
	local colWidth = 75

	boardWidth = math.Clamp( boardWidth, 400, 600 )
	boardHeight = GAMEMODE.ScoreDesign.Height

	xOffset = (ScrW() - boardWidth) / 2.0
	yOffset = (ScrH() - boardHeight) / 2.0
	yOffset = yOffset - ScrH() / 4.0
	yOffset = math.Clamp( yOffset, 32, ScrH() )

	// Background
	surface.SetDrawColor( 30, 30, 30, 200 )
	surface.DrawRect( xOffset, yOffset, boardWidth, GAMEMODE.ScoreDesign.HeaderY)

	surface.SetDrawColor( 90, 90, 90, 200 )
	surface.DrawRect( xOffset, yOffset+GAMEMODE.ScoreDesign.HeaderY, boardWidth, boardHeight-GAMEMODE.ScoreDesign.HeaderY)

	// Outline
	surface.SetDrawColor( 0, 0, 0, 150 )
	surface.DrawOutlinedRect( xOffset, yOffset, boardWidth, boardHeight )
	surface.SetDrawColor( 0, 0, 0, 50 )
	surface.DrawOutlinedRect( xOffset, yOffset, boardWidth, boardHeight)

	local hostname = GetHostName()
	local gamemodeName = "Gamemode By : " .. GAMEMODE.Author

	surface.SetTextColor( 255, 255, 255, 255 )

	surface.SetFont( "DermaDefaultBold" )
	local txWidth, txHeight = surface.GetTextSize( gamemodeName )
	local y = yOffset + 45
	surface.SetTextPos(xOffset + (boardWidth / 2) - (txWidth/2), y)
	surface.DrawText( gamemodeName )


	paintText(game.GetMap(), "DermaDefaultBold", xOffset + (boardWidth / 2), y + txHeight + 2, Color(255,255,255,255), true, false)


	if ( string.len(hostname) > 32 ) then
		surface.SetFont( "DermaLarge" )
	else
		surface.SetFont( "DermaLarge" )
	end

	local txWidth, txHeight = surface.GetTextSize( hostname )
	local y = yOffset + 15
	surface.SetTextPos(xOffset + (boardWidth / 2) - (txWidth/2), y)
	surface.DrawText( hostname )

	y = y + txHeight + 2

	y = y + txHeight + 4
	GAMEMODE.ScoreDesign.HeaderY = y - yOffset

	surface.SetDrawColor( 0, 0, 0, 100 )
	surface.DrawRect( xOffset, y-1, boardWidth, 1)

	surface.SetDrawColor( 255, 255, 255, 20 )
	surface.DrawRect( xOffset + boardWidth - (colWidth*1), y, colWidth, boardHeight-y + yOffset )

	surface.SetDrawColor( 255, 255, 255, 20 )
	surface.DrawRect( xOffset + boardWidth - (colWidth*3), y, colWidth, boardHeight-y + yOffset )

	surface.SetFont( "Trebuchet18" )
	local txWidth, txHeight = surface.GetTextSize( "W" )

	surface.SetDrawColor( 0, 0, 0, 100 )
	surface.DrawRect( xOffset, y, boardWidth, txHeight + 6 )


	surface.SetTextPos( xOffset + 16,								y)	surface.DrawText("#Name")
	surface.SetTextPos( xOffset + boardWidth - (colWidth*3) + 8,	y)	surface.DrawText("Money")
	surface.SetTextPos( xOffset + boardWidth - (colWidth*2) + 8,	y)	surface.DrawText("Kills")
	surface.SetTextPos( xOffset + boardWidth - (colWidth*1) + 8,	y)	surface.DrawText("#Ping")

	y = y + txHeight + 4

	local yPosition = y
	for team,info in pairs(ScoreboardInfo) do

		local teamText = info.TeamName .. "  (" .. #info.Players .. " Players)"

		surface.SetFont( "Trebuchet18" )
		surface.SetTextColor( 0, 0, 0, 255 )

		txWidth, txHeight = surface.GetTextSize( teamText )
		surface.SetDrawColor( info.Color.r, info.Color.g, info.Color.b, 255 )
		surface.DrawRect( xOffset+1, yPosition, boardWidth-2, txHeight + 4)
		yPosition = yPosition + 2
		surface.SetTextPos( xOffset + boardWidth/2 - txWidth/2, yPosition )
		surface.DrawText( teamText )




		yPosition = yPosition + txHeight + 2

		for index,plinfo in pairs(info.Players) do


			txWidth, txHeight = surface.GetTextSize( plinfo.Name )
			surface.SetDrawColor( 0, 0, 0, 255 )
			surface.DrawOutlinedRect( xOffset, yPosition, boardWidth, txHeight + 20)

			surface.SetFont( "Trebuchet18" )
			surface.SetTextColor( info.Color.r, info.Color.g, info.Color.b, 200 )
			surface.SetTextPos( xOffset + 32, yPosition )

			local client = plinfo.PlayerObj
			if plinfo.Team == TEAM_HUNK then
			local Hp = client:Health()
			local status
			local Hpcolorr = 0
			local Hpcolorg = 255
			local Hpcolorb = 0
			if Hp >= 75 then
					status = "Fine"
					Hpcolorg = 155
					Hpcolorr = 0
					Hpcolorb = 0
				elseif Hp >= 51 and Hp <= 74 then
					status = "Fine"
					Hpcolorg = 155
					Hpcolorr = 155
					Hpcolorb = 0
				elseif Hp >= 20 and Hp <= 50 then
					status = "Caution"
					Hpcolorg = 100
					Hpcolorr = 155
					Hpcolorb = 0
				elseif Hp <= 19 then
					status = "Danger"
					Hpcolorg = 0
					Hpcolorr = 155
				Hpcolorb = 0
				else
				status = "Dead"
				Hpcolorg = 0
				Hpcolorr = 0
				Hpcolorb = 0
			end
			surface.SetDrawColor( Hpcolorr,Hpcolorg, Hpcolorb, 150 )
			surface.DrawRect( xOffset, yPosition, boardWidth, txHeight + 20)
			surface.SetTextColor( Hpcolorr,Hpcolorg, Hpcolorb, 255 )
			if plinfo.Infected && plinfo.IsAlive then
				surface.SetDrawColor( 30,30, 30, 150 )
				surface.DrawRect( xOffset, yPosition + (txHeight + 20)/2 - (txHeight + 9)/2, boardWidth, txHeight + 9)
				surface.SetDrawColor( 111, 152, 49, 250 )
				surface.DrawRect( xOffset, yPosition + (txHeight + 20)/2 - (txHeight + 9)/2, (boardWidth)/(100/plinfo.InfectedPercent), txHeight + 9)
				surface.SetTextColor( 255,255, 255, 255 )
				draw.SimpleText( plinfo.InfectedPercent.."%", "Trebuchet18", ScrW()/2, yPosition + (txHeight + 20)/2, textcolor, 0, 1)
			end
			else
				surface.SetDrawColor( 200,200, 200, 150 )
				surface.DrawRect( xOffset, yPosition, boardWidth, txHeight + 20)
				surface.SetTextColor( 200,200, 200, 255 )
			end


			if GAMEMODE.Gamemode[GetGlobalString("Re2_Game")].Teams != nil && GAMEMODE.Gamemode[GetGlobalString("Re2_Game")].Teams then
				if plinfo.Re2Team == 1 then
					DrawIcon(surface.GetTextureID("re2_teams/stars"),boardWidth - 28,yPosition + 2,28,28 )
				elseif plinfo.Re2Team == 2 then
					DrawIcon(surface.GetTextureID("re2_teams/umbrella"),boardWidth - 28, yPosition + 2,28,28 )
				end
			end

			local px, py = xOffset + 16, yPosition
			local textcolor = Color( 255, 255, 255, alpha )
			local shadowcolor = Color( 0, 0, 0, alpha * 0.8 )

			draw.SimpleText( plinfo.Name, "Trebuchet18", px+1, py+7, shadowcolor )
			draw.SimpleText( plinfo.Name, "Trebuchet18", px, py+8, textcolor )

			px = xOffset + boardWidth - (colWidth*3) + 8
			draw.SimpleText( plinfo.Money, "Trebuchet18", px+1, py+7, shadowcolor )
			draw.SimpleText( plinfo.Money, "Trebuchet18", px, py+8, textcolor )

			px = xOffset + boardWidth - (colWidth*2) + 8
			draw.SimpleText( plinfo.Frags, "Trebuchet18", px+1, py+7, shadowcolor )
			draw.SimpleText( plinfo.Frags, "Trebuchet18", px, py+8, textcolor )

			px = xOffset + boardWidth - (colWidth*1) + 8
			draw.SimpleText( plinfo.Ping, "Trebuchet18", px+1, py+7, shadowcolor )
			draw.SimpleText( plinfo.Ping, "Trebuchet18", px, py+8, textcolor )

			yPosition = yPosition + txHeight + 20
		end
	end

	yPosition = yPosition + 8

	GAMEMODE.ScoreDesign.Height = (GAMEMODE.ScoreDesign.Height * 2) + (yPosition-yOffset)
	GAMEMODE.ScoreDesign.Height = GAMEMODE.ScoreDesign.Height / 3

end
