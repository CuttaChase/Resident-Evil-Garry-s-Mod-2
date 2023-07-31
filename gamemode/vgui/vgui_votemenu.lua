local w,h = ScrW(), ScrH()

local maincolor = Color( 125, 0, 0, 225 )

if not MENU then MENU = {} end
--------------------------------------------
VoteOption = {}
VoteOption["Map"] = MapListTable[1]
VoteOption["Game"] = "Survivor"
VoteOption["Difficulty"] = "Easy"

function MENU:VotingMenu()


	-----------------------------Voting Menu Frame base--------------------

	if GAMEMODE.InMenu and not self.Voting then return end
	if GetGlobalString("Mode") != "End" then return end
	if voted == true then return end
	if self.Voting then
		self.Voting:Remove()
		self.Voting = nil
		gui.EnableScreenClicker( false )
		GAMEMODE.InMenu = false
		return
	end
	gui.EnableScreenClicker( true )
	GAMEMODE.InMenu = true
	self.Voting = vgui.Create("DPanel")
	self.Voting:SetSize( w*0.25, h*0.7 )
	self.Voting:SetPos( w*0.5, h*0.3 )
	self.Voting:Center()
	self.Voting.Paint = function( pan, ww, hh )
		MENU:LargeStencilCut( ww, hh )
			surface.SetDrawColor( maincolor )
			surface.DrawRect( 0, 0, ww, hh )
		MENU:EndStencil()
		draw.SimpleTextOutlined( translate.Get("voting_menu"), "wOS.GenericLarge", ww/2, hh*0.1, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 0, color_white )
		surface.SetFont( "wOS.GenericLarge" )
		local tx, ty = surface.GetTextSize( "Voting" )
		surface.SetDrawColor( color_white )
		surface.DrawLine( ww/2 - tx/2, hh*0.1, ww/2 + tx/2, hh*0.1 )
	end

	local mw, mh = self.Voting:GetSize()

	------------------------------------------------------------------------------------------Voting Menu
	---------------Maps
	local VotingMaps = vgui.Create("DListView", self.Voting)
	VotingMaps:SetPos( mw*0.05, mh*0.22 )
	VotingMaps:SetSize( mw*0.9, mh*0.3 )
	VotingMaps:SetParent(self.Voting)
	VotingMaps:SetMultiSelect(false)
	VotingMaps:AddColumn(translate.Get("select_map"))
	

	-------------------------------------------------------------
	for k,v in pairs(MapListTable) do
		VotingMaps:AddLine(v)	
	end
	-------------------------------------------------------------

	VotingMaps:SelectFirstItem()
	VotingMaps.OnRowSelected = function(VotingMaps)
		VoteOption["Map"] = VotingMaps:GetSelected()[1]:GetValue(1)
	end
	--------------------------------------------------------------
	--------------------------------------------------------------
		--------------------------------------------------------------
	--------------------------------------------------------------
		--------------------------------------------------------------
	--------------------------------------------------------------
		--------------------------------------------------------------
	--------------------------------------------------------------
		--------------------------------------------------------------
	--------------------------------------------------------------
		--------------------------------------------------------------
	--------------------------------------------------------------
	--------------Merchant Time


	--------------------------------------------------------------
	--------------------------------------------------------------
		--------------------------------------------------------------
	--------------------------------------------------------------
		--------------------------------------------------------------
	--------------------------------------------------------------
		--------------------------------------------------------------
	--------------------------------------------------------------
		--------------------------------------------------------------
	--------------------------------------------------------------
		--------------------------------------------------------------
	--------------------------------------------------------------
	--------------Difficulty

			local GUI_Difficulty = vgui.Create("DComboBox")
			--GUI_Difficulty:AddColumn(translate.Get("difficulty_vote"))
			GUI_Difficulty:SetParent(self.Voting)

			--"Easy"
			--"Normal"
			--"Difficult"
			--"Expert"
			--"Suicidal"
			--"Death"
			--"RacoonCity"

			local easy = GUI_Difficulty:AddChoice( translate.Get("difficulty_name_easy"), "ea" ) -- Add our options
    		local norm = GUI_Difficulty:AddChoice( translate.Get("difficulty_name_normal"), "no" )
    		local diff = GUI_Difficulty:AddChoice( translate.Get("difficulty_name_difficult"), "di" )
    		local exp = GUI_Difficulty:AddChoice( translate.Get("difficulty_name_expert"), "ex" )
    		local suc = GUI_Difficulty:AddChoice( translate.Get("difficulty_name_suicidal"), "su" )


			GUI_Difficulty:SetSize( mw*0.4, mh*0.06 )
			GUI_Difficulty:SetPos( mw*0.5, mh*0.12 )
			GUI_Difficulty:ChooseOption( translate.Get("difficulty_name_easy") )

			function GUI_Difficulty:OnSelect( index, text, data )
				if data == "ea" then
					VoteOption["Difficulty"] = "Easy"
				elseif data == "no" then
					VoteOption["Difficulty"] = "Normal"
				elseif data == "di" then
					VoteOption["Difficulty"] = "Difficult"
				elseif data == "ex" then
					VoteOption["Difficulty"] = "Expert"
				elseif data == "su" then
					VoteOption["Difficulty"] = "Suicidal"
				end

			end
	--------------------------------------------------------------
	--------------------------------------------------------------
		--------------------------------------------------------------
	--------------------------------------------------------------
		--------------------------------------------------------------
	--------------------------------------------------------------
		--------------------------------------------------------------
	--------------------------------------------------------------
		--------------------------------------------------------------
	--------------------------------------------------------------
		--------------------------------------------------------------
	--------------------------------------------------------------
	--------------Gamemode
			local GUI_Gamemode_Selection = vgui.Create("DComboBox")
			GUI_Gamemode_Selection:SetParent(self.Voting)
			GUI_Gamemode_Selection:SetPos( mw*0.05, mh*0.12 )
			GUI_Gamemode_Selection:SetSize( mw*0.4, mh*0.06 )
			for h,j in pairs(GamemodeListTable) do
				GUI_Gamemode_Selection:AddChoice(translate.Get("gametype_" .. string.lower(j)))
			end
			GUI_Gamemode_Selection:ChooseOption( translate.Get("gametype_survivor") )

	function GUI_Gamemode_Selection:OnSelect(index,value,data)
			if value == "Escape" then
				VoteOption["Game"] = value
				VotingMaps:Clear()
				for k,v in pairs(EscapeListTable) do
					VotingMaps:AddLine(v)
				end
				VoteOption["Map"] = EscapeListTable[1] 
				VotingMaps:SelectFirstItem()			
			elseif value == "Boss" then
				VoteOption["Game"] = value
				VotingMaps:Clear()
				for k,v in pairs(BossListTable) do
					VotingMaps:AddLine(v)
				end
				VoteOption["Map"] = BossListTable[1] 
				VotingMaps:SelectFirstItem()			
			elseif (value != "Escape" && VoteOption["Game"] == "Escape") or (value != "Boss" && VoteOption["Game"] == "Boss") then 
				VoteOption["Game"] = value
				VotingMaps:Clear() 
				VoteOption["Map"] = MapListTable[1] 
				VotingMaps:SelectFirstItem()
				for k,v in pairs(MapListTable) do
					VotingMaps:AddLine(v)
				end 
			else
				VoteOption["Game"] = value
			end
			MsgN(value)
		end
	--------------------------------------------------------------
	--------------------------------------------------------------
		--------------------------------------------------------------
	--------------------------------------------------------------
		--------------------------------------------------------------
	--------------------------------------------------------------
		--------------------------------------------------------------
	--------------------------------------------------------------
		--------------------------------------------------------------
	--------------------------------------------------------------
		--------------------------------------------------------------
	--------------------------------------------------------------
	--------------Labels

			local GUI_Difficulty_Vote_Label = vgui.Create("DLabel")
			function GUI_Difficulty_Vote_Label:Think()
				GUI_Difficulty_Vote_Label:SetText(translate.Format("you_selected_difficulty", translate.Get("difficulty_name_" .. string.lower(VoteOption["Difficulty"]))))
			end
			GUI_Difficulty_Vote_Label:SetSize( 260,20 )
			GUI_Difficulty_Vote_Label:SetPos(mw*0.05, mh*0.55 )
			GUI_Difficulty_Vote_Label:SetParent(self.Voting)

			local GUI_Map_Vote_Label = vgui.Create("DLabel")
			function GUI_Map_Vote_Label:Think()
				GUI_Map_Vote_Label:SetText(translate.Format("you_selected_map", VoteOption["Map"]))
			end
			GUI_Map_Vote_Label:SetSize( 260,20  )
			GUI_Map_Vote_Label:SetPos(mw*0.05, mh*0.60 )
			GUI_Map_Vote_Label:SetParent(self.Voting)

			local GUI_Gamemode_Vote_Label = vgui.Create("DLabel")
			function GUI_Gamemode_Vote_Label:Think()
				GUI_Gamemode_Vote_Label:SetText(translate.Format("you_selected_gamemode", VoteOption["Game"]))
			end
			GUI_Gamemode_Vote_Label:SetSize( 260,20  )
			GUI_Gamemode_Vote_Label:SetPos(mw*0.05, mh*0.65 )
			GUI_Gamemode_Vote_Label:SetParent(self.Voting)


	--------------------------------------------------------------
	--------------------------------------------------------------
	--------------------------------------------------------------
	--------------------------------------------------------------
	--------------------------------------------------------------
	--------------------------------------------------------------
	--------------------------------------------------------------
	--------------------------------------------------------------
	--------------------------------------------------------------
	--------------------------------------------------------------
	--------------Vote Button------------------------------------
	local votebutt = vgui.Create( "DButton", self.Voting)
	votebutt:SetSize( mw*0.9, mh*0.12 )
	votebutt:SetPos( mw*0.05, mh*0.71 )
	votebutt:SetText( "" )
	votebutt.Paint = function( pan, ww, hh )
		MENU:StencilCut( ww, hh )
			surface.SetDrawColor( Color( 0, 0, 0, 175 ) )
			surface.DrawRect( 0, 0, ww, hh )
		MENU:EndStencil()
		draw.SimpleTextOutlined( translate.Get("submit_vote"), "wOS.GenericMed", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
	end
	votebutt.DoClick = function( pan )
		surface.PlaySound( "buttons/button14.wav" )
		self.Voting:Remove()
		self.Voting = nil
		gui.EnableScreenClicker( false )
		GAMEMODE.InMenu = false

		if GUI_Difficulty:GetSelected() == easy then
					VoteOption["Difficulty"] = "Easy"
				elseif GUI_Difficulty:GetSelected() == norm then
					VoteOption["Difficulty"] = "Normal"
				elseif GUI_Difficulty:GetSelected() == diff then
						VoteOption["Difficulty"] = "Difficult"
				elseif GUI_Difficulty:GetSelected() == exp then
						VoteOption["Difficulty"] = "Expert"
				elseif GUI_Difficulty:GetSelected() == suc then
						VoteOption["Difficulty"] = "Suicidal"
				end
				voted = true

				net.Start("VoteTransfer")
    			net.WriteString(VoteOption["Map"])
    			net.WriteString(VoteOption["Game"])
    			net.WriteString(VoteOption["Difficulty"])
    			net.SendToServer()
	end



	--------------Close Button------------------------------------
	local closebutt = vgui.Create( "DButton", self.Voting)
	closebutt:SetSize( mw*0.9, mh*0.12 )
	closebutt:SetPos( mw*0.05, mh*0.86 )
	closebutt:SetText( "" )
	closebutt.Paint = function( pan, ww, hh )
		MENU:StencilCut( ww, hh )
			surface.SetDrawColor( Color( 0, 0, 0, 175 ) )
			surface.DrawRect( 0, 0, ww, hh )
		MENU:EndStencil()
		draw.SimpleTextOutlined( translate.Get("voting_menu_close"), "wOS.GenericMed", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
	end
	closebutt.DoClick = function( pan )
		surface.PlaySound( "buttons/button14.wav" )
		self.Voting:Remove()
		self.Voting = nil
		gui.EnableScreenClicker( false )
		GAMEMODE.InMenu = false
	end

end
