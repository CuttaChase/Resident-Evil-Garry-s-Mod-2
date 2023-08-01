
VoteOption = {}



local RandomMapNames = {}

for k,v in pairs(GM.MapListTable) do

	table.insert(RandomMapNames,k)

end

local DefaultMapNames = {}

for k,v in pairs(GM.MapListTable2) do

	table.insert(DefaultMapNames,k)

end

local randommapchoice = table.Random(RandomMapNames)



if GM.MapListTable[randommapchoice].Escape != nil then randommapchoice = "re2_lab_v2" end

if GM.MapListTable[randommapchoice].Boss != nil then randommapchoice = "re2_lab_v2" end

if GM.MapListTable[randommapchoice].PVP != nil then randommapchoice = "re2_lab_v2" end

if GM.MapListTable[randommapchoice].Mercenaries != nil then randommapchoice = "re2_lab_v2" end

if GM.MapListTable[randommapchoice].VIP != nil then randommapchoice = "re2_lab_v2" end

if GM.MapListTable[randommapchoice].PVP != nil then randommapchoice = "re2_lab_v2" end



VoteOption["Map"] = randommapchoice



VoteOption["Game"] = "Survivor"

canvotep = true

VoteOption["Difficulty"] = "Normal"


function GUI_VoteMenu(voting)

	

	--if GetGlobalEntity("Mode") != "End" then return end

	local Iconent = ents.CreateClientProp("prop_physics")

	Iconent:SetPos(Vector(0,0,0))

	Iconent:Spawn()

	Iconent:Activate()



	local GUI_EndGameFrame = vgui.Create("DFrame")

	GUI_EndGameFrame:SetSize(400,400)

	GUI_EndGameFrame:Center()

	GUI_EndGameFrame:SetTitle("VoteMenu")

	GUI_EndGameFrame:MakePopup()


	local GUI_Vote_Background_Panel = vgui.Create("DPanelList")

	GUI_Vote_Background_Panel:SetSize(380,380)

	GUI_Vote_Background_Panel:SetPos(0,30)

	GUI_Vote_Background_Panel:SetParent(GUI_EndGameFrame)

	GUI_Vote_Background_Panel.Paint = function()

										end



		local GUI_Vote_Maps_Panel = vgui.Create("DPanelList")

		GUI_Vote_Maps_Panel:SetSize(180,340)

		GUI_Vote_Maps_Panel:SetPos(10,0)

		GUI_Vote_Maps_Panel:SetParent(GUI_Vote_Background_Panel)



		GUI_Map_List_Menu_Icon = vgui.Create("DImage", GUI_Vote_Maps_Panel)

		GUI_Map_List_Menu_Icon:SetSize(128,128)

		GUI_Map_List_Menu_Icon:SetPos(GUI_Vote_Maps_Panel:GetWide()/4, 10)



			local GUI_Map_List_Menu = vgui.Create("DListView")

			GUI_Map_List_Menu:SetParent(GUI_Vote_Maps_Panel)

			GUI_Map_List_Menu:SetSize(180,330)

			GUI_Map_List_Menu:SetPos(0,0)

			GUI_Map_List_Menu:SetMultiSelect(false)

			GUI_Map_List_Menu:AddColumn(translate.Get("select_map"))



			for k,v in pairs(GAMEMODE.MapListTable) do

				if v.Escape == nil and v.PVP == nil and v.Boss == nil and v.Mercenaries == nil and v.TeamVIP == nil and v.VIP == nil then

					GUI_Map_List_Menu:AddLine(k)
			
				end

			end



			GUI_Map_List_Menu:SelectFirstItem()



			GUI_Map_List_Menu.OnRowSelected = function(GUI_Map_List_Menu)



				VoteOption["Map"] = GUI_Map_List_Menu:GetSelected()[1]:GetValue(1)



			end





		local GUI_Vote_Settings_Panel = vgui.Create("DPanelList")

		GUI_Vote_Settings_Panel:SetSize(280  ,350)

		GUI_Vote_Settings_Panel:SetPos(210,40)

		GUI_Vote_Settings_Panel:SetParent(GUI_Vote_Background_Panel)



			local GUI_Difficulty_Label = vgui.Create("DLabel")

			GUI_Difficulty_Label:SetText(translate.Get("difficulty_vote"))

			GUI_Difficulty_Label:SizeToContents()

			GUI_Difficulty_Label:SetPos(210,80)

			GUI_Difficulty_Label:SetParent(GUI_Vote_Background_Panel)





			local GUI_Difficulty = vgui.Create( "DListView" )

			GUI_Difficulty:AddColumn(translate.Get("difficulty_vote"))

			GUI_Difficulty:SetParent(GUI_Vote_Background_Panel)

			GUI_Difficulty:SetMultiSelect( false )



			local easy = GUI_Difficulty:AddLine( translate.Get("difficulty_name_easy") ) -- Add our options
    			local norm = GUI_Difficulty:AddLine( translate.Get("difficulty_name_normal") )
    			local diff = GUI_Difficulty:AddLine( translate.Get("difficulty_name_difficult") )
    			local exp = GUI_Difficulty:AddLine( translate.Get("difficulty_name_expert") )
    			local suc = GUI_Difficulty:AddLine( translate.Get("difficulty_name_suicidal") )
    			local det = GUI_Difficulty:AddLine( translate.Get("difficulty_name_death") )
    			local rac = GUI_Difficulty:AddLine( translate.Get("difficulty_name_racooncity") )



			GUI_Difficulty:SetSize(100,120)

			GUI_Difficulty:SetPos(210,100)

			GUI_Difficulty:SelectItem(translate.Get(norm))



			function GUI_Difficulty:Think()

				if GUI_Difficulty:GetSelectedLine() == 1 then

					VoteOption["Difficulty"] = translate.Get("difficulty_name_easy")

				elseif GUI_Difficulty:GetSelectedLine() == 2 then

						VoteOption["Difficulty"] = translate.Get("difficulty_name_normal")

				elseif GUI_Difficulty:GetSelectedLine() == 3 then

						VoteOption["Difficulty"] = translate.Get("difficulty_name_difficult")

				elseif GUI_Difficulty:GetSelectedLine() == 4 then

						VoteOption["Difficulty"] = translate.Get("difficulty_name_expert")

				elseif GUI_Difficulty:GetSelectedLine() == 5 then

						VoteOption["Difficulty"] = translate.Get("difficulty_name_suicidal")
						
				elseif GUI_Difficulty:GetSelectedLine() == 6 then

						VoteOption["Difficulty"] = translate.Get("difficulty_name_death")
						
				elseif GUI_Difficulty:GetSelectedLine() == 7 then

						VoteOption["Difficulty"] = translate.Get("difficulty_name_racooncity")

				end

			end

			local GUI_Gamemode_Label = vgui.Create("DLabel")

			GUI_Gamemode_Label:SetText(translate.Get("gamemode"))

			GUI_Gamemode_Label:SizeToContents()

			GUI_Gamemode_Label:SetPos(210,20)

			GUI_Gamemode_Label:SetParent(GUI_Vote_Background_Panel)



			local GUI_Gamemode_Selection = vgui.Create("DComboBox")

			GUI_Gamemode_Selection:SetParent(GUI_Vote_Background_Panel)

			GUI_Gamemode_Selection:SetPos(210,40)

			GUI_Gamemode_Selection:SetSize( 220, 20 )

				for h,j in pairs(GAMEMODE.Gamemode) do

					if j.Name != nil then

						GUI_Gamemode_Selection:AddChoice(translate.Get("gametype_" .. string.lower(tostring(j.Name))))

					else

						GUI_Gamemode_Selection:AddChoice(translate.Get("gametype_" .. string.lower(tostring(h))))

					end

				end

			GUI_Gamemode_Selection:ChooseOption( translate.Get("gametype_survivor") )







			function GUI_Gamemode_Selection:OnSelect(index,value,data)

				if value == "Escape" then

					local bool = false

					for k,v in pairs(GAMEMODE.MapListTable) do

						if v.Escape != nil then

							if (!bool) then

								GUI_Map_List_Menu:Clear()

							end

							GUI_Map_List_Menu:AddLine(k)

							bool = true

						end

					end

					if (bool) then

						GUI_Map_List_Menu:SelectFirstItem()

						VoteOption["Game"] = value

						VoteOption["Map"] = GUI_Map_List_Menu:GetSelected()[1]:GetValue(1)

					else

						GUI_Gamemode_Selection:ChooseOption( translate.Get("gametype_survivor") )

						LocalPlayer():ChatPrint(translate.Format("no_maps_for_gametype", translate.Get("gametype_" .. string.lower(value))))

					end
					
				elseif value == "Survivor" then

					local bool = false

					for k,v in pairs(GAMEMODE.MapListTable) do

						if v.Survivor != nil then

							if (!bool) then

								GUI_Map_List_Menu:Clear()

							end

							GUI_Map_List_Menu:AddLine(k)

							bool = true

						end

					end

					if (bool) then

						GUI_Map_List_Menu:SelectFirstItem()

						VoteOption["Game"] = value

						VoteOption["Map"] = GUI_Map_List_Menu:GetSelected()[1]:GetValue(1)

					else

						GUI_Gamemode_Selection:ChooseOption( translate.Get("gametype_survivor") )

						LocalPlayer():ChatPrint(translate.Format("no_maps_for_gametype", translate.Get("gametype_" .. string.lower(value))))

					end

				elseif value == "Boss" then
				
					local bool = false

					for k,v in pairs(GAMEMODE.MapListTable) do

						if v.Boss != nil then

							if (!bool) then

								GUI_Map_List_Menu:Clear()

							end

							GUI_Map_List_Menu:AddLine(k)

							bool = true

						end

					end

					if (bool) then

						GUI_Map_List_Menu:SelectFirstItem()

						VoteOption["Game"] = value

						VoteOption["Map"] = GUI_Map_List_Menu:GetSelected()[1]:GetValue(1)

					else

						GUI_Gamemode_Selection:ChooseOption( translate.Get("gametype_survivor") )

						LocalPlayer():ChatPrint(translate.Format("no_maps_for_gametype", translate.Get("gametype_" .. string.lower(value))))

					end
					
				elseif value == "TeamVIP" then
				
					local bool = false

					for k,v in pairs(GAMEMODE.MapListTable) do

						if v.TeamVIP != nil then

							if (!bool) then

								GUI_Map_List_Menu:Clear()

							end

							GUI_Map_List_Menu:AddLine(k)

							bool = true

						end

					end

					if (bool) then

						GUI_Map_List_Menu:SelectFirstItem()

						VoteOption["Game"] = value

						VoteOption["Map"] = GUI_Map_List_Menu:GetSelected()[1]:GetValue(1)

					else

						GUI_Gamemode_Selection:ChooseOption( translate.Get("gametype_survivor") )

						LocalPlayer():ChatPrint(translate.Format("no_maps_for_gametype", translate.Get("gametype_" .. string.lower(value))))

					end
					
				elseif value == "VIP" then
				
					local bool = false

					for k,v in pairs(GAMEMODE.MapListTable) do

						if v.VIP != nil then

							if (!bool) then

								GUI_Map_List_Menu:Clear()

							end

							GUI_Map_List_Menu:AddLine(k)

							bool = true

						end

					end

					if (bool) then

						GUI_Map_List_Menu:SelectFirstItem()

						VoteOption["Game"] = value

						VoteOption["Map"] = GUI_Map_List_Menu:GetSelected()[1]:GetValue(1)

					else

						GUI_Gamemode_Selection:ChooseOption( translate.Get("gametype_survivor") )

						LocalPlayer():ChatPrint(translate.Format("no_maps_for_gametype", translate.Get("gametype_" .. string.lower(value))))

					end
					
				elseif value == "Mercenaries" then
				
					local bool = false

					for k,v in pairs(GAMEMODE.MapListTable) do

						if v.Mercenaries != nil then

							if (!bool) then

								GUI_Map_List_Menu:Clear()

							end

							GUI_Map_List_Menu:AddLine(k)

							bool = true

						end

					end

					if (bool) then

						GUI_Map_List_Menu:SelectFirstItem()

						VoteOption["Game"] = value

						VoteOption["Map"] = GUI_Map_List_Menu:GetSelected()[1]:GetValue(1)

					else

						GUI_Gamemode_Selection:ChooseOption( translate.Get("gametype_survivor") )

						LocalPlayer():ChatPrint(translate.Format("no_maps_for_gametype", translate.Get("gametype_" .. string.lower(value))))

					end
					
				elseif value == "PVP" then
				
					local bool = false

					for k,v in pairs(GAMEMODE.MapListTable) do

						if v.PVP != nil then

							if (!bool) then

								GUI_Map_List_Menu:Clear()

							end

							GUI_Map_List_Menu:AddLine(k)

							bool = true

						end

					end

					if (bool) then

						GUI_Map_List_Menu:SelectFirstItem()

						VoteOption["Game"] = value

						VoteOption["Map"] = GUI_Map_List_Menu:GetSelected()[1]:GetValue(1)

					else

						GUI_Gamemode_Selection:ChooseOption( translate.Get("gametype_survivor") )

						LocalPlayer():ChatPrint(translate.Format("no_maps_for_gametype", translate.Get("gametype_" .. string.lower(value))))

					end

				elseif value != "Escape" && VoteOption["Game"] == "Escape" then



					local bool = false

					for k,v in pairs(GAMEMODE.MapListTable) do

						if v.Escape == nil then

							if (!bool) then

								GUI_Map_List_Menu:Clear()

							end

							GUI_Map_List_Menu:AddLine(k)

							bool = true

						end

					end

					if bool then

						VoteOption["Game"] = value



						GUI_Map_List_Menu:SelectFirstItem()



						VoteOption["Map"] = GUI_Map_List_Menu:GetSelected()[1]:GetValue(1)

					else

						LocalPlayer():ChatPrint(translate.Format("no_maps_for_gametype", translate.Get("gametype_" .. string.lower(value))))

					end
					
				elseif value != "Survivor" && VoteOption["Game"] == "Survivor" then



					local bool = false

					for k,v in pairs(GAMEMODE.MapListTable) do

						if v.Survivor == nil then

							if (!bool) then

								GUI_Map_List_Menu:Clear()

							end

							GUI_Map_List_Menu:AddLine(k)

							bool = true

						end

					end

					if bool then

						VoteOption["Game"] = value



						GUI_Map_List_Menu:SelectFirstItem()



						VoteOption["Map"] = GUI_Map_List_Menu:GetSelected()[1]:GetValue(1)

					else

						LocalPlayer():ChatPrint(translate.Format("no_maps_for_gametype", translate.Get("gametype_" .. string.lower(value))))

					end
					
				elseif value != "Boss" && VoteOption["Game"] == "Boss" then



					local bool = false

					for k,v in pairs(GAMEMODE.MapListTable) do

						if v.Boss == nil then

							if (!bool) then

								GUI_Map_List_Menu:Clear()

							end

							GUI_Map_List_Menu:AddLine(k)

							bool = true

						end

					end

					if bool then

						VoteOption["Game"] = value



						GUI_Map_List_Menu:SelectFirstItem()



						VoteOption["Map"] = GUI_Map_List_Menu:GetSelected()[1]:GetValue(1)

					else

						LocalPlayer():ChatPrint(translate.Format("no_maps_for_gametype", translate.Get("gametype_" .. string.lower(value))))

					end
					
				elseif value != "VIP" && VoteOption["Game"] == "VIP" then



					local bool = false

					for k,v in pairs(GAMEMODE.MapListTable) do

						if v.VIP == nil then

							if (!bool) then

								GUI_Map_List_Menu:Clear()

							end

							GUI_Map_List_Menu:AddLine(k)

							bool = true

						end

					end

					if bool then

						VoteOption["Game"] = value



						GUI_Map_List_Menu:SelectFirstItem()



						VoteOption["Map"] = GUI_Map_List_Menu:GetSelected()[1]:GetValue(1)

					else

						LocalPlayer():ChatPrint(translate.Format("no_maps_for_gametype", translate.Get("gametype_" .. string.lower(value))))

					end
					
				elseif value != "TeamVIP" && VoteOption["Game"] == "TeamVIP" then



					local bool = false

					for k,v in pairs(GAMEMODE.MapListTable) do

						if v.TeamVIP == nil then

							if (!bool) then

								GUI_Map_List_Menu:Clear()

							end

							GUI_Map_List_Menu:AddLine(k)

							bool = true

						end

					end

					if bool then

						VoteOption["Game"] = value



						GUI_Map_List_Menu:SelectFirstItem()



						VoteOption["Map"] = GUI_Map_List_Menu:GetSelected()[1]:GetValue(1)

					else

						LocalPlayer():ChatPrint(translate.Format("no_maps_for_gametype", translate.Get("gametype_" .. string.lower(value))))

					end
					
				elseif value != "Mercenaries" && VoteOption["Game"] == "Mercenaries" then



					local bool = false

					for k,v in pairs(GAMEMODE.MapListTable) do

						if v.Mercenaries == nil then

							if (!bool) then

								GUI_Map_List_Menu:Clear()

							end

							GUI_Map_List_Menu:AddLine(k)

							bool = true

						end

					end

					if bool then

						VoteOption["Game"] = value



						GUI_Map_List_Menu:SelectFirstItem()



						VoteOption["Map"] = GUI_Map_List_Menu:GetSelected()[1]:GetValue(1)

					else

						LocalPlayer():ChatPrint(translate.Format("no_maps_for_gametype", translate.Get("gametype_" .. string.lower(value))))

					end
					
				elseif value != "PVP" && VoteOption["Game"] == "PVP" then



					local bool = false

					for k,v in pairs(GAMEMODE.MapListTable) do

						if v.PVP == nil then

							if (!bool) then

								GUI_Map_List_Menu:Clear()

							end

							GUI_Map_List_Menu:AddLine(k)

							bool = true

						end

					end

					if bool then

						VoteOption["Game"] = value



						GUI_Map_List_Menu:SelectFirstItem()



						VoteOption["Map"] = GUI_Map_List_Menu:GetSelected()[1]:GetValue(1)

					else

						LocalPlayer():ChatPrint(translate.Format("no_maps_for_gametype", value))

					end



				end

			end





		local GUI_Vote_Confirmation_Panel = vgui.Create("DPanelList")

		GUI_Vote_Confirmation_Panel:SetSize(210  ,170)

		GUI_Vote_Confirmation_Panel:SetPos(180,230)

		GUI_Vote_Confirmation_Panel:SetParent(GUI_Vote_Background_Panel)



			local GUI_Difficulty_Vote_Label = vgui.Create("DLabel")



			function GUI_Difficulty_Vote_Label:Think()

				GUI_Difficulty_Vote_Label:SetText(translate.Format("you_selected_difficulty", translate.Get("difficulty_name_" .. string.lower(VoteOption["Difficulty"]))))

			end



			GUI_Difficulty_Vote_Label:SetSize( 260,20 )

			GUI_Difficulty_Vote_Label:SetPos(20,10)

			GUI_Difficulty_Vote_Label:SetParent(GUI_Vote_Confirmation_Panel)



			local GUI_Map_Vote_Label = vgui.Create("DLabel")



			function GUI_Map_Vote_Label:Think()

				GUI_Map_Vote_Label:SetText(translate.Format("you_selected_map", VoteOption["Map"]))

			end



			GUI_Map_Vote_Label:SetSize( 260,20 )

			GUI_Map_Vote_Label:SetPos(20,35)

			GUI_Map_Vote_Label:SetParent(GUI_Vote_Confirmation_Panel)



			local GUI_Gamemode_Vote_Label = vgui.Create("DLabel")



			function GUI_Gamemode_Vote_Label:Think()

				GUI_Gamemode_Vote_Label:SetText(translate.Format("you_selected_gamemode", translate.Get("gametype_" .. string.lower(VoteOption["Game"]))))

			end



			GUI_Gamemode_Vote_Label:SetSize( 240,20 )

			GUI_Gamemode_Vote_Label:SetPos(20,60)

			GUI_Gamemode_Vote_Label:SetParent(GUI_Vote_Confirmation_Panel)



			local GUI_Submit_Vote = vgui.Create("DButton")

			GUI_Submit_Vote:SetParent( GUI_Vote_Confirmation_Panel )

			GUI_Submit_Vote:SetText( translate.Get("submit_vote")  )



			local x,y = GUI_Vote_Confirmation_Panel:GetSize()



			GUI_Submit_Vote:SetPos(20, 90)

			GUI_Submit_Vote:SetSize( x - 40,20 )

			GUI_Submit_Vote.DoClick = function ( btn )

				if GUI_Difficulty:GetSelectedLine() == easy then

					VoteOption["Difficulty"] = translate.Get("difficulty_name_easy")

				elseif GUI_Difficulty:GetSelectedLine() == norm then

						VoteOption["Difficulty"] = translate.Get("difficulty_name_normal")

				elseif GUI_Difficulty:GetSelectedLine() == diff then

						VoteOption["Difficulty"] = translate.Get("difficulty_name_difficult")

				elseif GUI_Difficulty:GetSelectedLine() == exp then

						VoteOption["Difficulty"] = translate.Get("difficulty_name_expert")

				elseif GUI_Difficulty:GetSelectedLine() == suc then

						VoteOption["Difficulty"] = translate.Get("difficulty_name_suicidal")
						
				elseif GUI_Difficulty:GetSelectedLine() == det then

						VoteOption["Difficulty"] = translate.Get("difficulty_name_death")
						
				elseif GUI_Difficulty:GetSelectedLine() == rac then

						VoteOption["Difficulty"] = translate.Get("difficulty_name_racooncity")

				end

				SendDataToServer()

				GUI_Submit_Vote:SetText(translate.Get("change_vote"))
				    net.Start("VoteTransfer")
    				net.WriteString(VoteOption["Map"])
    				net.WriteString(VoteOption["Game"])
    				net.WriteString(VoteOption["Difficulty"])
    				net.SendToServer()

			end



end
 concommand.Add("Re2_VoteMenu",function(ply,cmd,args) GUI_VoteMenu(true) end)