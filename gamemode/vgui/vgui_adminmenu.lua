local w,h = ScrW(), ScrH()

local maincolor = Color( 125, 0, 0, 225 )

if not MENU then MENU = {} end

function MENU:AdminMenu()


	-----------------------------Admin Menu Frame base--------------------

	if GAMEMODE.InMenu and not self.Admin then return end

	if self.Admin then
		self.Admin:Remove()
		self.Admin = nil
		gui.EnableScreenClicker( false )
		GAMEMODE.InMenu = false
		return
	end
	gui.EnableScreenClicker( true )
	GAMEMODE.InMenu = true
	self.Admin = vgui.Create("DPanel")
	self.Admin:SetSize( w*0.25, h*0.8 )
	self.Admin:SetPos( w*0.5, h*0.1 )
	self.Admin:Center()
	self.Admin.Paint = function( pan, ww, hh )
		MENU:LargeStencilCut( ww, hh )
			surface.SetDrawColor( maincolor )
			surface.DrawRect( 0, 0, ww, hh )
		MENU:EndStencil()
		draw.SimpleTextOutlined( "Admin", "wOS.GenericLarge", ww/2, hh*0.05, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 0, color_white )
		surface.SetFont( "wOS.GenericLarge" )
		local tx, ty = surface.GetTextSize( "Admin" )
		surface.SetDrawColor( color_white )
		surface.DrawLine( ww/2 - tx/2, hh*0.05, ww/2 + tx/2, hh*0.05 )
	end

 mw, mh = self.Admin:GetSize()

	------------------------------------------------------------------------------------------Admin MENU

	local ply = LocalPlayer()

		local PauseTimer = vgui.Create( "DButton", self.Admin)
		PauseTimer:SetSize( mw*0.9, mh*0.12 )
		PauseTimer:SetPos( mw*0.05, mh*0.24 )
		PauseTimer:SetText( "" )
		PauseTimer.Paint = function( pan, ww, hh )
			MENU:StencilCut( ww, hh )
				surface.SetDrawColor( Color( 0, 0, 0, 175 ) )
				surface.DrawRect( 0, 0, ww, hh )
			MENU:EndStencil()
			draw.SimpleTextOutlined( "Pause", "wOS.GenericMed", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		end
		PauseTimer.DoClick = function( pan )
			surface.PlaySound( "buttons/button14.wav" )
			net.Start("PauseTimer")
			net.SendToServer()
		end

		local UnPauseTimer = vgui.Create( "DButton", self.Admin)
		UnPauseTimer:SetSize( mw*0.9, mh*0.12 )
		UnPauseTimer:SetPos( mw*0.05, mh*0.36 )
		UnPauseTimer:SetText( "" )
		UnPauseTimer.Paint = function( pan, ww, hh )
			MENU:StencilCut( ww, hh )
				surface.SetDrawColor( Color( 0, 0, 0, 175 ) )
				surface.DrawRect( 0, 0, ww, hh )
			MENU:EndStencil()
			draw.SimpleTextOutlined( "UnPause", "wOS.GenericMed", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		end
		UnPauseTimer.DoClick = function( pan )
			surface.PlaySound( "buttons/button14.wav" )
			net.Start("UnPauseTimer")
			net.SendToServer()
		end


-------change mode------
local ChangeMode = vgui.Create( "DButton", self.Admin)
ChangeMode:SetSize( mw*0.9, mh*0.12 )
ChangeMode:SetPos( mw*0.05, mh*0.6 )
ChangeMode:SetText( "" )
ChangeMode.Paint = function( pan, ww, hh )
	MENU:StencilCut( ww, hh )
		surface.SetDrawColor( Color( 0, 0, 0, 175 ) )
		surface.DrawRect( 0, 0, ww, hh )
	MENU:EndStencil()
	draw.SimpleTextOutlined( "Gamemode", "wOS.GenericMed", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
end

changemodepage = vgui.Create("DPanel")
changemodepage:SetSize( w*0.25, h*0.3 )
changemodepage:SetPos( w*0.1, h*0.5 )
changemodepage:Hide()
changemodepage.Paint = function( pan, ww, hh )
	MENU:LargeStencilCut( ww, hh )
		surface.SetDrawColor( maincolor )
		surface.DrawRect( 0, 0, ww, hh )
	MENU:EndStencil()
end

local modelist = vgui.Create( "DListView", changemodepage )
modelist:SetMultiSelect( false )
modelist:AddColumn( "Change Gamemode" )
modelist:SetSize( mw*0.8, mh*0.35 )
modelist:SetPos( mw*0.1, mh*0.015 )
local surv = modelist:AddLine( "Survivor" ) -- Add our options
local vip = modelist:AddLine( "VIP" )
local boss = modelist:AddLine( "Boss" )
local tvip = modelist:AddLine( "TeamVIP" )
local esc = modelist:AddLine( "Escape" )
local merc = modelist:AddLine( "Mercenaries" )
local lms = modelist:AddLine( "LastManStanding" )
local dom = modelist:AddLine( "Doom" )

modelist.OnRowSelected = function( lst, index, pnl )
				surface.PlaySound( "buttons/button14.wav" )
				changemodepage:Hide()
				gmname = pnl:GetColumnText( 1 )
				net.Start("SetMode")
				net.WriteString(gmname)
				net.SendToServer()
end

ChangeMode.DoClick = function( pan )
	surface.PlaySound( "buttons/button14.wav" )
	changemodepage:ToggleVisible()
	createweaponPAge:Hide()
end

--------difficulty changing--------
local ChangeDifficulty = vgui.Create( "DButton", self.Admin)
ChangeDifficulty:SetSize( mw*0.9, mh*0.12 )
ChangeDifficulty:SetPos( mw*0.05, mh*0.48 )
ChangeDifficulty:SetText( "" )
ChangeDifficulty.Paint = function( pan, ww, hh )
	MENU:StencilCut( ww, hh )
		surface.SetDrawColor( Color( 0, 0, 0, 175 ) )
		surface.DrawRect( 0, 0, ww, hh )
	MENU:EndStencil()
	draw.SimpleTextOutlined( "Difficulty", "wOS.GenericMed", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
end

difficultypage = vgui.Create("DPanel")
difficultypage:SetSize( w*0.25, h*0.3 )
difficultypage:SetPos( w*0.65, h*0.5 )
difficultypage:Hide()
difficultypage.Paint = function( pan, ww, hh )
	MENU:LargeStencilCut( ww, hh )
		surface.SetDrawColor( maincolor )
		surface.DrawRect( 0, 0, ww, hh )
	MENU:EndStencil()
end

local diffmenu = vgui.Create( "DListView", difficultypage )
diffmenu:SetMultiSelect( false )
diffmenu:AddColumn( "Change Difficulty" )
diffmenu:SetSize( mw*0.8, mh*0.33 )
diffmenu:SetPos( mw*0.1, mh*0.015 )
local easy = diffmenu:AddLine( "Easy" ) -- Add our options
local norm = diffmenu:AddLine( "Normal" )
local diff = diffmenu:AddLine( "Difficult" )
local exp = diffmenu:AddLine( "Expert" )
local suc = diffmenu:AddLine( "Suicidal" )

diffmenu.OnRowSelected = function( lst, index, pnl )
diffselection = pnl:GetColumnText( 1 )
difficultypage:Hide()
	net.Start("SetDifficulty")
	net.WriteString(diffselection)
	net.SendToServer()
end


ChangeDifficulty.DoClick = function( pan )
	surface.PlaySound( "buttons/button14.wav" )
	difficultypage:ToggleVisible()
	healpage:Hide()
	itempage:Hide()
end


------------Heal & Cure
local healAndcure = vgui.Create( "DButton", self.Admin)
healAndcure:SetSize( mw*0.9, mh*0.12 )
healAndcure:SetPos( mw*0.05, mh*0.72 )
healAndcure:SetText( "" )
healAndcure.Paint = function( pan, ww, hh )
	MENU:StencilCut( ww, hh )
		surface.SetDrawColor( Color( 0, 0, 0, 175 ) )
		surface.DrawRect( 0, 0, ww, hh )
	MENU:EndStencil()
	draw.SimpleTextOutlined( "Heal & Cure", "wOS.GenericMed", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
end

healpage = vgui.Create("DPanel")
healpage:SetSize( w*0.25, h*0.3 )
healpage:SetPos( w*0.65, h*0.5 )
healpage:Hide()
healpage.Paint = function( pan, ww, hh )
	MENU:LargeStencilCut( ww, hh )
		surface.SetDrawColor( maincolor )
		surface.DrawRect( 0, 0, ww, hh )
	MENU:EndStencil()
end

local healmenu = vgui.Create( "DListView", healpage )
healmenu:SetMultiSelect( false )
healmenu:AddColumn( "Heal And Cure" )
healmenu:SetSize( mw*0.8, mh*0.33 )
healmenu:SetPos( mw*0.1, mh*0.015 )

playerstable2 = player.GetAll()
for k, v in pairs( playerstable2 ) do
	healmenu:AddLine( v:Name() )
end

healmenu.OnRowSelected = function( lst, index, pnl )
pname = pnl:GetColumnText( 1 )
ply:ChatPrint("You have healed: "..pname)
	net.Start("fixPlayer")
	net.WriteString(pname)
	net.SendToServer()
end



local HCall = healpage:Add( "DCheckBoxLabel" ) -- Create the checkbox
HCall:SetPos( mw*0.3, mh*0.35 )						-- Set the position
HCall:SetText("Heal & Cure All Players")
function HCall:OnChange()
	surface.PlaySound( "buttons/button14.wav" )
	net.Start("fixPlayerall")
	net.SendToServer()
	healpage:ToggleVisible()
end



healAndcure.DoClick = function( pan )
healpage:ToggleVisible()
itempage:Hide()
difficultypage:Hide()


	surface.PlaySound( "buttons/button14.wav" )
	--[[local comboBoxHeal = vgui.Create( "DComboBox", self.Admin )
				comboBoxHeal:SetPos( mw*0.075, mh*0.75 )
				comboBoxHeal:SetSize( 100, 30 )
				comboBoxHeal:SetValue( "Players" )
				playerstable2 = player.GetAll()
				for k, v in pairs( playerstable2 ) do
					comboBoxHeal:AddChoice( v:Name() )
				end

				comboBoxHeal.OnSelect = function( _, _, value )
					SIDSelected2 = playerstable2[comboBoxHeal:GetSelectedID()]:SteamID()
					plynameSelected2 = playerstable2[comboBoxHeal:GetSelectedID()]:Name()
					ply:ChatPrint("You have healed: "..plynameSelected2)
					--net.Start("fixPlayer")
					--net.WriteString(SIDSelected2)
					--net.SendToServer()
					comboBoxHeal:Remove()
				end]]
		end


-----------------spawn Items----------------
		local createItem = vgui.Create( "DButton", self.Admin)
		createItem:SetSize( mw*0.45, mh*0.05 )
		createItem:SetPos( mw*0.50, mh*0.88 )
		createItem:SetText( "" )
		createItem.Paint = function( pan, ww, hh )
			MENU:StencilCut( ww, hh )
				surface.SetDrawColor( Color( 0, 0, 0, 175 ) )
				surface.DrawRect( 0, 0, ww, hh )
			MENU:EndStencil()
			draw.SimpleTextOutlined( "Spawn Item", "wOS.GenericMed", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		end

		itempage = vgui.Create("DPanel")
		itempage:SetSize( w*0.25, h*0.3 )
		itempage:SetPos( w*0.65, h*0.5 )
		itempage:Hide()
		itempage.Paint = function( pan, ww, hh )
			MENU:LargeStencilCut( ww, hh )
				surface.SetDrawColor( maincolor )
				surface.DrawRect( 0, 0, ww, hh )
			MENU:EndStencil()
		end

		local Itemlist = vgui.Create( "DListView", itempage )
		Itemlist:SetMultiSelect( false )
		Itemlist:AddColumn( "Items" )
		Itemlist:SetSize( mw*0.8, mh*0.3 )
		Itemlist:SetPos( mw*0.1, mh*0.015 )

		for item,data in pairs(itemtypes) do
			Itemlist:AddLine(data)
		end

		Itemlist.OnRowSelected = function( lst, index, pnl )
						surface.PlaySound( "buttons/button14.wav" )
						playerPos = LocalPlayer():GetPos() + Vector(0,0,8)
						iname = pnl:GetColumnText( 1 )
						 table.KeyFromValue(itemtypes,iname)
							net.Start("CreateItem")
							net.WriteVector(playerPos)
							net.WriteString(table.KeyFromValue(itemtypes,iname))
							net.SendToServer()
						chat.AddText("Created "..pnl:GetColumnText( 1 ))
						--itempage:Remove()
end

createItem.DoClick = function()
	surface.PlaySound( "buttons/button14.wav" )
	itempage:ToggleVisible()
	healpage:Hide()
	difficultypage:Hide()
		end

------------spawn weapons----------
		local createweapon = vgui.Create( "DButton", self.Admin)
		createweapon:SetSize( mw*0.45, mh*0.05 )
		createweapon:SetPos( mw*0.05, mh*0.88 )
		createweapon:SetText( "" )
		createweapon.Paint = function( pan, ww, hh )
			MENU:StencilCut( ww, hh )
				surface.SetDrawColor( Color( 0, 0, 0, 175 ) )
				surface.DrawRect( 0, 0, ww, hh )
			MENU:EndStencil()
			draw.SimpleTextOutlined( "Spawn Weapon", "wOS.GenericMed", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		end

		createweaponPAge = vgui.Create("DPanel")
		createweaponPAge:SetSize( w*0.25, h*0.3 )
		createweaponPAge:SetPos( w*0.1, h*0.5 )
		createweaponPAge:Hide()
		createweaponPAge.Paint = function( pan, ww, hh )
			MENU:LargeStencilCut( ww, hh )
				surface.SetDrawColor( maincolor )
				surface.DrawRect( 0, 0, ww, hh )
			MENU:EndStencil()
		end

		local AppList = vgui.Create( "DListView", createweaponPAge )
		AppList:SetMultiSelect( false )
		AppList:AddColumn( "Weapons" )
		AppList:SetSize( mw*0.8, mh*0.35 )
		AppList:SetPos( mw*0.1, mh*0.015 )
		for weapon,data in pairs(weapontypes) do
			AppList:AddLine(data)
		end

		AppList.OnRowSelected = function( lst, index, pnl )
						surface.PlaySound( "buttons/button14.wav" )
						wname = pnl:GetColumnText( 1 )
						table.KeyFromValue(weapontypes,wname)
						playerPos = LocalPlayer():GetPos() + Vector(0,0,8)
						net.Start("CreateWeapon")
						net.WriteString(table.KeyFromValue(weapontypes,wname))
						net.WriteVector(playerPos)
						net.SendToServer()
						chat.AddText("Created "..pnl:GetColumnText( 1 ).."")
		end

		createweapon.DoClick = function( pan )
			surface.PlaySound( "buttons/button14.wav" )
createweaponPAge:ToggleVisible()
changemodepage:Hide()
difficultypage:Hide()
		end

---------------------Set money--------
local SetMoneyBtn = vgui.Create( "DButton", self.Admin)
SetMoneyBtn:SetSize( mw*0.9, mh*0.12 )
SetMoneyBtn:SetPos( mw*0.05, mh*0.12 )
SetMoneyBtn:SetText( "" )
SetMoneyBtn.Paint = function( pan, ww, hh )
	MENU:StencilCut( ww, hh )
		surface.SetDrawColor( Color( 0, 0, 0, 175 ) )
		surface.DrawRect( 0, 0, ww, hh )
	MENU:EndStencil()
	draw.SimpleTextOutlined( "Set Money", "wOS.GenericMed", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
end
SetMoneyBtn.DoClick = function()
              local DComboBox = vgui.Create( "DComboBox", self.Admin )
                    DComboBox:SetPos( mw*0.05, mh*0.12 )
					DComboBox:SetSize( 100, 30 )
                    DComboBox:SetValue( "Select Player" )
                    playerstable = player:GetAll()
                    for k, v in pairs( playerstable ) do
	                   DComboBox:AddChoice( v:Name().." : "..v:GetNWInt("Money") )

                    DComboBox.OnSelect = function( self, index, value )
						SIDSelected = playerstable[DComboBox:GetSelectedID()]:SteamID()
						plymoneySelected = playerstable[DComboBox:GetSelectedID()]:GetNWInt("Money")
						plynameSelected = playerstable[DComboBox:GetSelectedID()]:Name()
						local TextEntry = vgui.Create( "DTextEntry", self.Admin )
                            TextEntry:SetPos( mw*1.2, mh*0.45 )
                            TextEntry:SetSize( 100, 30 )
                            TextEntry:SetNumeric( true )
                            TextEntry:SetText( plymoneySelected )
							TextEntry:MakePopup()
									TextEntry.OnEnter = function( self )
									money = self:GetValue()
									chat.AddText("Set "..plynameSelected.." money to "..money)
									net.Start("SetMoney")
									net.WriteString(SIDSelected)
									net.WriteString(money)
									net.SendToServer()
									DComboBox:Remove()
									TextEntry:Remove()

									end
					end
					end
			end






	--------------Close Button------------------------------------
	local closebutt = vgui.Create( "DButton", self.Admin)
	closebutt:SetSize( mw*0.9, mh*0.06 )
	closebutt:SetPos( mw*0.05, mh*0.94 )
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
		self.Admin:Remove()
		createweaponPAge:Remove()
		itempage:Remove()
		healpage:Remove()
		changemodepage:Remove()
		difficultypage:Remove()
		self.Admin = nil
		gui.EnableScreenClicker( false )
		GAMEMODE.InMenu = false
	end


end
