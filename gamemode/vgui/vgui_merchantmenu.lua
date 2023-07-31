local w,h = ScrW(), ScrH()

local maincolor = Color( 125, 0, 0, 225 )

if not MENU then MENU = {} end

MENU.LastMerc = "Shop"

MENU.MercTabs = {

	[ "Shop" ] = function() MENU:MerchantShop() end,
	[ "Storage" ] = function() MENU:MerchantStorage() end,
	[ "Perks" ] = function() MENU:MerchantPerks() end,
	[ "Upgrades" ] = function() MENU:MerchantUpgrades() end,
	[ "PlayerModels" ] = function() MENU:MerchantPlayerModel() end,
}

MENU.PaintTabs = {

	[ "merchant_category_storage" ] = function( pan, mw, mh )
			local ww, hh = MENU.MerchantFill:GetSize()
			local posx, posy = MENU.MerchantFill:GetPos()
			draw.SimpleTextOutlined( translate.Get("storage_title"), "wOS.GenericLarge", posx + ww*0.7/2, hh*0.05, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
			surface.SetFont( "wOS.GenericLarge" )
			local tx, ty = surface.GetTextSize( translate.Get("storage_title") )
			surface.SetDrawColor( color_white )
			surface.DrawLine( posx + ww*0.7/2 - tx/2, hh*0.05 + ty/2, posx + ww*0.7/2 + tx/2, hh*0.05 + ty/2 )

			draw.SimpleTextOutlined( translate.Get("storage_inventory_title"), "wOS.GenericLarge", posx + ww*0.7 + ww*0.3/2, hh*0.05, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
			tx, ty = surface.GetTextSize( "Inventory" )
			surface.SetDrawColor( color_white )
			surface.DrawLine( posx + ww*0.7 + ww*0.3/2 - tx/2, hh*0.05 + ty/2, posx + ww*0.7 + ww*0.3/2 + tx/2, hh*0.05 + ty/2 )

		end,

	[ "merchant_category_shop" ] = function( pan, mw, mh )
			local ww, hh = MENU.MerchantFill:GetSize()
			local posx, posy = MENU.MerchantFill:GetPos()
			draw.SimpleTextOutlined( translate.Format("shop_x_storage_slots", table.Count( LocalPlayer().Chest ), LocalPlayer():GetMaxStorage()), "wOS.GenericMed", posx + ww*0.97, mh*0.05, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 0, color_white )
			draw.SimpleTextOutlined( translate.Format("shop_current_money", LocalPlayer():GetNWInt( "Money", 0 )), "wOS.GenericMed", posx, mh*0.05, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, color_white )
			draw.SimpleTextOutlined( translate.Get("shop_title"), "wOS.GenericLarge", posx + ww/2, mh*0.02, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 0, color_white )
			surface.SetFont( "wOS.GenericLarge" )
			local tx, ty = surface.GetTextSize( translate.Get("shop_title") )
			surface.SetDrawColor( color_white )
			surface.DrawLine( posx + ww/2 - tx/2, mh*0.02 + ty, posx + ww/2 + tx/2, mh*0.02 + ty )
		end,

	[ "merchant_category_perks" ] = function( pan, mw, mh )
			local ww, hh = MENU.MerchantFill:GetSize()
			local posx, posy = MENU.MerchantFill:GetPos()
			draw.SimpleTextOutlined( translate.Format("shop_current_money", LocalPlayer():GetNWInt( "Money", 0 )), "wOS.GenericMed", posx, mh*0.05, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, color_white )
			draw.SimpleTextOutlined( translate.Get("perkmenu_title"), "wOS.GenericLarge", posx + ww/2, mh*0.02, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 0, color_white )
			surface.SetFont( "wOS.GenericLarge" )
			local tx, ty = surface.GetTextSize( translate.Get("perkmenu_title") )
			surface.SetDrawColor( color_white )
			surface.DrawLine( posx + ww/2 - tx/2, mh*0.02 + ty, posx + ww/2 + tx/2, mh*0.02 + ty )
		end,

	[ "merchant_category_upgrades" ] = function( pan, mw, mh )
			local ww, hh = MENU.MerchantFill:GetSize()
			local posx, posy = MENU.MerchantFill:GetPos()
			draw.SimpleTextOutlined( translate.Format("shop_current_money", LocalPlayer():GetNWInt( "Money", 0 )), "wOS.GenericMed", posx, mh*0.05, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, color_white )
			draw.SimpleTextOutlined( translate.Get("weapon_upgrades_title"), "wOS.GenericLarge", posx + ww/2, mh*0.02, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 0, color_white )
			surface.SetFont( "wOS.GenericLarge" )
			local tx, ty = surface.GetTextSize( translate.Get("weapon_upgrades_title") )
			surface.SetDrawColor( color_white )
			surface.DrawLine( posx + ww/2 - tx/2, mh*0.02 + ty, posx + ww/2 + tx/2, mh*0.02 + ty )
		end,

		[ "merchant_category_playermodels" ] = function( pan, mw, mh )
				local ww, hh = MENU.MerchantFill:GetSize()
				local posx, posy = MENU.MerchantFill:GetPos()
				draw.SimpleTextOutlined( translate.Format("shop_current_money", LocalPlayer():GetNWInt( "Money", 0 )), "wOS.GenericMed", posx, mh*0.05, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, color_white )
				draw.SimpleTextOutlined( translate.Get("playermodels_title"), "wOS.GenericLarge", posx + ww/2, mh*0.02, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 0, color_white )
				surface.SetFont( "wOS.GenericLarge" )
				local tx, ty = surface.GetTextSize( translate.Get("playermodels_title") )
				surface.SetDrawColor( color_white )
				surface.DrawLine( posx + ww/2 - tx/2, mh*0.02 + ty, posx + ww/2 + tx/2, mh*0.02 + ty )
			end,
			
}

function MENU:MerchantMenu()

	if GAMEMODE.InMenu and not self.MainMerchant then return end
	if GetGlobalString("Mode") != "Merchant" and LocalPlayer():Team() == TEAM_HUNK then return end

	if self.MainMerchant then
		self.MainMerchant:Remove()
		self.MainMerchant = nil
		gui.EnableScreenClicker( false )
		GAMEMODE.InMenu = false
		return
	end
	surface.PlaySound( table.Random( GAMEMODE.Config.MerchantOpen ) )
	gui.EnableScreenClicker( true )
	GAMEMODE.InMenu = true

	self.MainMerchant = vgui.Create( "DPanel" )
	self.MainMerchant:SetSize( w*0.5, h*0.6 )
	--self.MainMerchant:SetPos( w*0.4, h*0.2 )
  self.MainMerchant:Center()
	self.MainMerchant.Paint = function( pan, ww, hh )

		if GetGlobalString("Mode") != "Merchant" and LocalPlayer():Team() == TEAM_HUNK then
			MENU.MainMerchant:Remove()
			MENU.MainMerchant = nil
			gui.EnableScreenClicker( false )
			GAMEMODE.InMenu = false
		end

		MENU:LargeStencilCut( ww, hh )
			surface.SetDrawColor( maincolor )
			surface.DrawRect( 0, 0, ww, hh )
		MENU:EndStencil()

		surface.SetDrawColor( color_white )
		surface.DrawLine( ww*0.28, hh*0.05, ww*0.28, hh*0.95 )

		if MENU.PaintTabs[ MENU.LastMerc ] then
			MENU.PaintTabs[ MENU.LastMerc ]( pan, ww, hh )
			return
		end

		local mw, mmh = MENU.MerchantFill:GetSize()
		local posx, posy = MENU.MerchantFill:GetPos()

		draw.SimpleTextOutlined( translate.Get("merchant_category_" .. string.lower(self.LastMerc)), "wOS.GenericLarge", posx + mw/2, hh*0.05, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		surface.SetFont( "wOS.GenericLarge" )
		local tx, ty = surface.GetTextSize( self.LastMerc )
		surface.SetDrawColor( color_white )
		surface.DrawLine( posx + mw/2 - tx/2, hh*0.05 + ty/2, posx + mw/2 + tx/2, hh*0.05 + ty/2 )
	end
	self.MainMerchant.Think = function()
		--Put this here as well just in case
		if GetGlobalString("Mode") != "Merchant" and LocalPlayer():Team() == TEAM_HUNK then
			MENU.MainMerchant:Remove()
			MENU.MainMerchant = nil
			gui.EnableScreenClicker( false )
			GAMEMODE.InMenu = false
		end
	end
	local mw, mh = self.MainMerchant:GetSize()

	self.MerchantFill = vgui.Create( "DPanel", self.MainMerchant )
	self.MerchantFill:SetPos( mw*0.29, mh*0.075 )
	self.MerchantFill:SetSize( mw*0.71, mh*0.85 )
	self.MerchantFill.Paint = function()
	end

	local tabframe = vgui.Create( "DPanelList", self.MainMerchant )
	tabframe:SetSize( mw*0.25, mh*0.85 )
	tabframe:SetPos( mw*0.02, mh*0.075 )
	tabframe:SetSpacing( mh*0.05 )
	tabframe:EnableVerticalScrollbar(true)
	tabframe.VBar.Paint = function() end
	tabframe.VBar.btnUp.Paint = function() end
	tabframe.VBar.btnDown.Paint = function() end
	tabframe.VBar.btnGrip.Paint = function() end
	tabframe.Paint = function( pan, ww, hh )
	end

	local tw, th = tabframe:GetSize()
	local sizey = th/9
	local start = true
	for name, buttfunc in pairs( MENU.MercTabs ) do
		local SIDE_BUTTON = vgui.Create( "DButton", tabframe )
		SIDE_BUTTON:SetSize( tw*0.98, sizey )
		if start then
			SIDE_BUTTON:SetPos( 0, mh*0.05 )
			start = false
		end
		SIDE_BUTTON:SetText("")
		SIDE_BUTTON.Paint = function(pan, ww, hh)
			MENU:LargeStencilCut( ww, hh )
				surface.SetDrawColor( Color( 0, 0, 0, 155 ) )
				surface.DrawRect( 0, 0, ww, hh )
			MENU:EndStencil()
			if SIDE_BUTTON:IsHovered() then
				draw.SimpleTextOutlined( translate.Get("merchant_category_" .. string.lower(name)), "wOS.GenericMed", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
			else
				draw.SimpleTextOutlined( translate.Get("merchant_category_" .. string.lower(name)), "wOS.GenericMed", ww/2, hh/2, Color( 155, 155, 155, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color( 155, 155, 155, 255 ) )
			end
		end
		SIDE_BUTTON.DoClick = function()
			if MENU.LastMerc == name then return end
			MENU.LastMerc = name
			surface.PlaySound( "buttons/button14.wav" )
			buttfunc()
		end
		tabframe:AddItem(SIDE_BUTTON)
	end

	local closebutt = vgui.Create( "DButton", self.Options )
	closebutt:SetSize( tw*0.98, sizey )
	closebutt:SetText( "" )
	closebutt.Paint = function( pan, ww, hh )
		MENU:LargeStencilCut( ww, hh )
			surface.SetDrawColor( Color( 0, 0, 0, 155 ) )
			surface.DrawRect( 0, 0, ww, hh )
		MENU:EndStencil()
		if closebutt:IsHovered() then
			draw.SimpleTextOutlined( translate.Get("merchant_menu_close"), "wOS.GenericMed", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		else
			draw.SimpleTextOutlined( translate.Get("merchant_menu_close"), "wOS.GenericMed", ww/2, hh/2, Color( 155, 155, 155, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color( 155, 155, 155, 255 ) )
		end
	end
	closebutt.DoClick = function( pan )
		surface.PlaySound( table.Random( GAMEMODE.Config.MerchantClose ) )
		self.MainMerchant:Remove()
		self.MainMerchant = nil
		gui.EnableScreenClicker( false )
		GAMEMODE.InMenu = false
	end
	tabframe:AddItem( closebutt )

	MENU.MercTabs[ MENU.LastMerc ]()

end

function MENU:MerchantShop()

	self.MerchantFill:Clear()
	local mmw, mmh = self.MainMerchant:GetSize()
	local mw, mh = self.MerchantFill:GetSize()

	local itemlist = vgui.Create( "DPanelList", self.MerchantFill )
	itemlist:SetSize( mw, mh )
	itemlist:SetSpacing( mh*0.02 )
	itemlist:EnableVerticalScrollbar(true)
	itemlist.VBar.Paint = function() end
	itemlist.VBar.btnUp.Paint = function() end
	itemlist.VBar.btnDown.Paint = function() end
	itemlist.VBar.btnGrip.Paint = function() end
	itemlist.Paint = function() end

	local cats = {}
	local tempcats = item.GetCategories()
	for k,v in pairs(tempcats) do
		if k == "Admin" then continue end
		cats[k] = v
	end


	for cat, _ in pairs( cats ) do
		local items = item.GetCategoryItems( cat )
		local bw, bh = mw*0.2, mh*0.2
		local padx, pady = mw*0.02, mh*0.02
		local offsety = 0
		local offsetx = padx

		local cppan = vgui.Create("DCollapsibleCategory", itemlist )
		cppan:SetSize( mmw*0.71, mh*0.1 )
		cppan:SetExpanded( true )
		cppan:SetLabel("")
		cppan.Paint = function(pan, ww, hh)
			pan.OldHeight = mh*0.04
			MENU:TopLeftStencilCut( mmw*0.69, mh*0.04 )
				surface.SetDrawColor( Color( 255, 255, 255, 125 ) )
				surface.DrawRect( 0, 0, mmw*0.69, mh*0.04 )
			MENU:EndStencil()
			if cppan:GetExpanded() then
				draw.SimpleTextOutlined( translate.Get("shop_item_category_" .. string.lower(cat)) or cat, "wOS.GenericMed", mw/2, mh*0.015, color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_black )
			else
				draw.SimpleTextOutlined( translate.Get("shop_item_category_" .. string.lower(cat)) or cat, "wOS.GenericMed", mw/2, mh*0.015, Color( 155, 155, 155, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color( 155, 155, 155, 255 ) )
			end
		end
		cppan:SetStartHeight( mh*0.04 )

		local idealsize = ( math.ceil( #items/4 ) )*( bh + padx )

		local catlist = vgui.Create("DScrollPanel", cppan )
		catlist:SetSize( mw, idealsize )
		catlist:SetPos( 0, mh*0.05 )
		catlist.Paint = function() end
		catlist.VBar.Paint = function() end
		catlist.VBar.btnUp.Paint = function() end
		catlist.VBar.btnDown.Paint = function() end
		catlist.VBar.btnGrip.Paint = function() end

		itemlist:AddItem(cppan)

		for class, data in pairs( items ) do

			if offsetx + bw >= mw then
				offsetx = padx
				offsety = offsety + pady + bh
			end

			local UmbPanel = vgui.Create( "DPanel", catlist )
			UmbPanel:SetPos( offsetx, offsety )
			UmbPanel:SetSize( bw, bh )
			UmbPanel.Paint = function( pan, ww, hh )
				MENU:LargeStencilCut( ww, hh )
					surface.SetDrawColor( Color( 0, 0, 0, 175 ) )
					surface.DrawRect( 0, 0, ww, hh )
				MENU:EndStencil()
			end

			local Iconent = ClientsideModel("borealis/barrel.mdl")
			Iconent:SetAngles(Angle(0,0,0))
			Iconent:SetPos(Vector(0,0,0))
			Iconent:Spawn()
			Iconent:Activate()

			local uw, uh = UmbPanel:GetSize()
			local ItemIcon = vgui.Create( "DModelPanel", UmbPanel )
			ItemIcon:SetSize( uw, uh )
			ItemIcon:SetModel( data.Model )

			Iconent:SetModel( data.Model )
			local center = Iconent:OBBCenter()
			local dist = Iconent:BoundingRadius()*1.6

			ItemIcon:SetLookAt( center )
			ItemIcon:SetCamPos( center + Vector( dist, dist, 0 ) )
			Iconent:Remove()

			local DataMask = vgui.Create( "DPanel", UmbPanel )
			DataMask:SetSize( uw, uh )
			DataMask.Paint = function( pan, ww, hh )

				if data.Restrictions then
					if not data.Restrictions[ LocalPlayer():GetUserGroup() ] then
						draw.SimpleTextOutlined( translate.Get("item_slot_locked"), "wOS.GenericMed", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
						return
					end
				end
				draw.SimpleTextOutlined( translate.Get("item_name_" .. data.Name), "wOS.GenericSmall", ww/2, hh*0.03, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 0, color_white )
				draw.SimpleTextOutlined( translate.Get("item_desc_" .. data.Desc), "wOS.GenericSmall", ww/2, hh*0.15, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 0, color_white )
				draw.SimpleTextOutlined( translate.Format("item_price_x", data.Price), "wOS.GenericSmall", ww/2, hh*0.97, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 0, color_white )
				if data.Max > 1 then
					draw.SimpleTextOutlined( "x" .. data.Max, "wOS.GenericSmall", ww*0.95, hh*0.02, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 0, color_white )
				end
			end

			offsetx = offsetx + bw + padx

			if data.Restrictions then
				if not data.Restrictions[ LocalPlayer():GetUserGroup() ] then
					continue
				end
			end

			local ItemButt = vgui.Create( "DButton", UmbPanel )
			ItemButt:SetSize( uw, uh )
			ItemButt:SetText( "" )
			ItemButt.Paint = function( pan, ww, hh )
			end
			ItemButt.DoClick = function( pan )
				if ItemButt.ItemIconOptions then ItemButt.ItemIconOptions:Remove() ItemButt.ItemIconOptions = nil end
				ItemButt.ItemIconOptions = DermaMenu( UmbPanel )
				ItemButt.ItemIconOptions:SetPos( gui.MouseX(), gui.MouseY() )
				ItemButt.ItemIconOptions.Think = function( self )
					if not MENU.LastMerc == "Shop" then self:Remove() end
					if not MENU.MainMerchant then self:Remove() end
					if GetGlobalString("Mode") != "Merchant" and LocalPlayer():Team() == TEAM_HUNK then self:Remove() end
				end
				ItemButt.ItemIconOptions:AddOption( translate.Get("shop_buy_button"), function()
					net.Start( "REGmod.BuyItem" )
						net.WriteString( data.ClassName, 32 )
					net.SendToServer()
				end )
			end

		end

	end

end

function MENU:MerchantStorage()

	self.MerchantFill:Clear()
	local mmw, mmh = self.MainMerchant:GetSize()
	local mw, mh = self.MerchantFill:GetSize()

	local itemlist = vgui.Create( "DScrollPanel", self.MerchantFill )
	itemlist:SetSize( mw*0.7, mh )
	itemlist.VBar.Paint = function() end
	itemlist.VBar.btnUp.Paint = function() end
	itemlist.VBar.btnDown.Paint = function() end
	itemlist.VBar.btnGrip.Paint = function() end
	itemlist.Paint = function( pan, ww, hh )
	end

	local bw, bh = mw*0.2, mh*0.2
	local padx, pady = mw*0.02, mh*0.02
	local offsety = 0
	local offsetx = padx

	for i = 1, GAMEMODE.Config.MaxStorageSlots do

		if offsetx + bw >= mw*0.7 then
			offsetx = padx
			offsety = offsety + pady + bh
		end

		local UmbPanel = vgui.Create( "DPanel", itemlist )
		UmbPanel:SetPos( offsetx, offsety )
		UmbPanel:SetSize( bw, bh )
		UmbPanel.Paint = function( pan, ww, hh )
			MENU:LargeStencilCut( ww, hh )
				surface.SetDrawColor( Color( 0, 0, 0, 175 ) )
				surface.DrawRect( 0, 0, ww, hh )
			MENU:EndStencil()
			if i > LocalPlayer():GetNWInt( "MaxStorage", GAMEMODE.Config.InitialStorageSlots ) then
				draw.SimpleTextOutlined( translate.Get("item_slot_locked"), "wOS.GenericMed", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
				return
			end

			if not LocalPlayer().Chest[ i ] then
				draw.SimpleTextOutlined( translate.Get("item_slot_empty"), "wOS.GenericMed", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
				return
			end
		end

		local uw,uh = UmbPanel:GetSize()

		if LocalPlayer().Chest[ i ] then
			local data = item.GetItem( LocalPlayer().Chest[ i ].Item )
			local amount = LocalPlayer().Chest[ i ].Amount
			if data then
				local Iconent = ClientsideModel("borealis/barrel.mdl")
				Iconent:SetAngles(Angle(0,0,0))
				Iconent:SetPos(Vector(0,0,0))
				Iconent:Spawn()
				Iconent:Activate()

				local ItemIcon = vgui.Create( "DModelPanel", UmbPanel )
				ItemIcon:SetSize( uw, uh )
				ItemIcon:SetModel( data.Model )
				Iconent:SetModel( data.Model )

				local center = Iconent:OBBCenter()
				local dist = Iconent:BoundingRadius()*1.6

				ItemIcon:SetLookAt( center )
				ItemIcon:SetCamPos( center + Vector( dist, dist, 0 ) )
				Iconent:Remove()

				local DataMask = vgui.Create( "DPanel", UmbPanel )
				DataMask:SetSize( uw, uh )
				DataMask.Paint = function( pan, ww, hh )
					if data.Restrictions then
						if not data.Restrictions[ LocalPlayer():GetUserGroup() ] then
							draw.SimpleTextOutlined( translate.Get("item_slot_locked"), "wOS.GenericMed", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
							return
						end
					end
					draw.SimpleTextOutlined( translate.Get("item_name_" .. data.Name), "wOS.GenericSmall", ww/2, hh*0.03, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 0, color_white )
					draw.SimpleTextOutlined( translate.Get("item_desc_" .. data.Desc), "wOS.GenericSmall", ww/2, hh*0.15, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 0, color_white )
					if amount > 1 then
						draw.SimpleTextOutlined( "x" .. amount, "wOS.GenericSmall", ww*0.95, hh*0.02, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 0, color_white )
					end
				end

				local ItemButt = vgui.Create( "DButton", UmbPanel )
				ItemButt:SetSize( uw, uh )
				ItemButt:SetText( "" )
				ItemButt.Paint = function( pan, ww, hh )
				end
				ItemButt.SlotPos = i
				ItemButt.DoClick = function( pan )
					if ItemButt.ItemIconOptions then ItemButt.ItemIconOptions:Remove() ItemButt.ItemIconOptions = nil end
					ItemButt.ItemIconOptions = DermaMenu( UmbPanel )
					ItemButt.ItemIconOptions:SetPos( gui.MouseX(), gui.MouseY() )
					ItemButt.ItemIconOptions.Think = function( self )
						if not MENU.LastMerc == "Storage" then self:Remove() end
						if not MENU.MainMerchant then self:Remove() end
						if GetGlobalString("Mode") != "Merchant" and LocalPlayer():Team() == TEAM_HUNK then self:Remove() end
					end

					ItemButt.ItemIconOptions:AddOption( translate.Get("storage_equip_button"), function()
						net.Start( "REGmod.EquipItem" )
							net.WriteInt( ItemButt.SlotPos, 32 )
						net.SendToServer()
						ItemButt.ItemIconOptions:Remove()
					end )

					ItemButt.ItemIconOptions:AddOption( translate.Get("storage_sell_button"), function()
						net.Start( "REGmod.SellItem" )
							net.WriteBool( false )
							net.WriteInt( ItemButt.SlotPos, 32 )
						net.SendToServer()
						ItemButt.ItemIconOptions:Remove()
					end )
				end
			end
		elseif i > LocalPlayer():GetNWInt( "MaxStorage", GAMEMODE.Config.InitialStorageSlots ) then
			local ItemButt = vgui.Create( "DButton", UmbPanel )
			ItemButt:SetSize( uw, uh )
			ItemButt:SetText( "" )
			ItemButt.Paint = function( pan, ww, hh )
			end
			ItemButt.DoClick = function( pan )
				if ItemButt.ItemIconOptions then ItemButt.ItemIconOptions:Remove() ItemButt.ItemIconOptions = nil end
				ItemButt.ItemIconOptions = DermaMenu( UmbPanel )
				ItemButt.ItemIconOptions:SetPos( gui.MouseX(), gui.MouseY() )
				ItemButt.ItemIconOptions.Think = function( self )
					if not MENU.LastMerc == "Storage" then self:Remove() end
					if not MENU.MainMerchant then self:Remove() end
					if GetGlobalString("Mode") != "Merchant" and LocalPlayer():Team() == TEAM_HUNK then self:Remove() end
				end

				ItemButt.ItemIconOptions:AddOption( translate.Format("storage_purchase_slot", GAMEMODE.Config.StorageSlotPrice), function()
					net.Start( "REGmod.PurchaseStorageSlot" )
					net.SendToServer()
					ItemButt.ItemIconOptions:Remove()
				end )
			end
		end
		offsetx = offsetx + bw + padx
	end

	local invlist = vgui.Create( "DScrollPanel", self.MerchantFill )
	invlist:SetSize( mw*0.3, mh )
	invlist:SetPos( mw*0.7, 0 )
	invlist.VBar.Paint = function() end
	invlist.VBar.btnUp.Paint = function() end
	invlist.VBar.btnDown.Paint = function() end
	invlist.VBar.btnGrip.Paint = function() end
	invlist.Paint = function( pan, ww, hh )
	end

	mw,mh = invlist:GetSize()

	bw, bh = mw*0.94, mh*0.25
	padx, pady = mw*0.01, mh*0.02
	offsety = 0
	offsetx = padx


	for i = 1, 10 do
		if offsetx + bw >= mw then
			offsetx = padx
			offsety = offsety + pady + bh
		end

		local UmbPanel = vgui.Create( "DPanel", invlist )
		UmbPanel:SetPos( offsetx, offsety )
		UmbPanel:SetSize( bw, bh )
		UmbPanel.Paint = function( pan, ww, hh )
			MENU:LargeStencilCut( ww, hh )
				surface.SetDrawColor( Color( 0, 0, 0, 175 ) )
				surface.DrawRect( 0, 0, ww, hh )
			MENU:EndStencil()

			if not LocalPlayer().inventory[ i ] then
				draw.SimpleTextOutlined( translate.Get("item_slot_locked"), "wOS.GenericMed", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
				return
			end

			if LocalPlayer().inventory[ i ].Item == 0 then
				draw.SimpleTextOutlined( translate.Get("item_slot_empty"), "wOS.GenericMed", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
				return
			end

		end

		local uw,uh = UmbPanel:GetSize()

		if LocalPlayer().inventory[ i ] then
			if LocalPlayer().inventory[ i ].Item != 0 then
				local data = item.GetItem( LocalPlayer().inventory[ i ].Item )
				local amount = LocalPlayer().inventory[ i ].Amount or 1
				if data then
					local Iconent = ClientsideModel("borealis/barrel.mdl")
					Iconent:SetAngles(Angle(0,0,0))
					Iconent:SetPos(Vector(0,0,0))
					Iconent:Spawn()
					Iconent:Activate()

					local ItemIcon = vgui.Create( "DModelPanel", UmbPanel )
					ItemIcon:SetSize( uw, uh )
					ItemIcon:SetModel( data.Model )
					Iconent:SetModel( data.Model )

					local center = Iconent:OBBCenter()
					local dist = Iconent:BoundingRadius()*1.6

					ItemIcon:SetLookAt( center )
					ItemIcon:SetCamPos( center + Vector( dist, dist, 0 ) )
					Iconent:Remove()

					local DataMask = vgui.Create( "DPanel", UmbPanel )
					DataMask:SetSize( uw, uh )
					DataMask.Paint = function( pan, ww, hh )
						if data.Restrictions then
							if not data.Restrictions[ LocalPlayer():GetUserGroup() ] then
								draw.SimpleTextOutlined( translate.Get("item_slot_locked"), "wOS.GenericMed", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
								return
							end
						end
						draw.SimpleTextOutlined( translate.Get("item_name_" .. data.Name), "wOS.GenericSmall", ww/2, hh*0.03, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 0, color_white )
						draw.SimpleTextOutlined( translate.Get("item_desc_" .. data.Desc), "wOS.GenericSmall", ww/2, hh*0.15, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 0, color_white )
						if amount > 1 then
							draw.SimpleTextOutlined( "x" .. amount, "wOS.GenericSmall", ww*0.95, hh*0.02, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 0, color_white )
						end
						draw.SimpleTextOutlined( translate.Format("item_slot_x", i), "wOS.GenericSmall", ww/2, hh*0.98, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 0, color_white )

					end

					local ItemButt = vgui.Create( "DButton", UmbPanel )
					ItemButt:SetSize( uw, uh )
					ItemButt:SetText( "" )
					ItemButt.SlotPos = i
					ItemButt.Paint = function( pan, ww, hh )
					end
					ItemButt.DoClick = function( pan )
						if ItemButt.ItemIconOptions then ItemButt.ItemIconOptions:Remove() ItemButt.ItemIconOptions = nil end
						ItemButt.ItemIconOptions = DermaMenu( UmbPanel )
						ItemButt.ItemIconOptions:SetPos( gui.MouseX(), gui.MouseY() )
						ItemButt.ItemIconOptions.Think = function( self )
							if not MENU.LastMerc == "Storage" then self:Remove() end
							if not MENU.MainMerchant then self:Remove() end
							if GetGlobalString("Mode") != "Merchant" and LocalPlayer():Team() == TEAM_HUNK then self:Remove() end
						end

						ItemButt.ItemIconOptions:AddOption( translate.Get("storage_store_button"), function()
							net.Start( "REGmod.StoreItem" )
								net.WriteInt( ItemButt.SlotPos, 32 )
							net.SendToServer()
							ItemButt.ItemIconOptions:Remove()
						end )

						ItemButt.ItemIconOptions:AddOption( translate.Get("storage_sell_button"), function()
							net.Start( "REGmod.SellItem" )
								net.WriteBool( true )
								net.WriteInt( ItemButt.SlotPos, 32 )
							net.SendToServer()
							ItemButt.ItemIconOptions:Remove()
						end )

					end
				end
			end
		else
			local ItemButt = vgui.Create( "DButton", UmbPanel )
			ItemButt:SetSize( uw, uh )
			ItemButt:SetText( "" )
			ItemButt.Paint = function( pan, ww, hh )
			end
			ItemButt.DoClick = function( pan )
				if ItemButt.ItemIconOptions then ItemButt.ItemIconOptions:Remove() ItemButt.ItemIconOptions = nil end
				ItemButt.ItemIconOptions = DermaMenu( UmbPanel )
				ItemButt.ItemIconOptions:SetPos( gui.MouseX(), gui.MouseY() )
				ItemButt.ItemIconOptions.Think = function( self )
					if not MENU.LastMerc == "Storage" then self:Remove() end
					if not MENU.MainMerchant then self:Remove() end
					if GetGlobalString("Mode") != "Merchant" and LocalPlayer():Team() == TEAM_HUNK then self:Remove() end
				end

				ItemButt.ItemIconOptions:AddOption( translate.Format("storage_purchase_slot", GAMEMODE.Config.InventorySlotPrice), function()
					net.Start( "REGmod.PurchaseInventorySlot" )
					net.SendToServer()
					ItemButt.ItemIconOptions:Remove()
				end )

			end
		end
		offsetx = offsetx + bw + padx
	end

end

function MENU:MerchantPerks()

	self.MerchantFill:Clear()
	local mmw, mmh = self.MainMerchant:GetSize()
	local mw, mh = self.MerchantFill:GetSize()

	local itemlist = vgui.Create( "DPanelList", self.MerchantFill )
	itemlist:SetSize( mw, mh*0.88 )
	itemlist:SetPos( 0, mh*0.12 )
	itemlist:SetSpacing( mh*0.02 )
	itemlist:EnableVerticalScrollbar(true)
	itemlist.VBar.Paint = function() end
	itemlist.VBar.btnUp.Paint = function() end
	itemlist.VBar.btnDown.Paint = function() end
	itemlist.VBar.btnGrip.Paint = function() end
	itemlist.Paint = function() end

	local cats = perky.GetCategories()

	--Purchasable Perks

	for cat, _ in pairs( cats ) do
		local items = perky.GetCategoryItems( cat )
		local bw, bh = mmw*0.69, mh*0.2
		local padx, pady = mw*0.02, mh*0.02
		local offsety = 0
		local offsetx = padx

		local cppan = vgui.Create( "DCollapsibleCategory", itemlist )
		cppan:SetSize( mmw*0.71, mh*0.1 )
		cppan:SetExpanded( true )
		cppan:SetLabel("")
		cppan.Paint = function(pan, ww, hh)
			pan.OldHeight = mh*0.04
			MENU:TopLeftStencilCut( mmw*0.69, mh*0.04 )
				surface.SetDrawColor( Color( 255, 255, 255, 125 ) )
				surface.DrawRect( 0, 0, mmw*0.69, mh*0.04 )
			MENU:EndStencil()
			if cppan:GetExpanded() then
				draw.SimpleTextOutlined( translate.Get("perkmenu_perk_category_" .. string.lower(cat)) or cat, "wOS.GenericMed", mw/2, mh*0.015, color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_black )
			else
				draw.SimpleTextOutlined( translate.Get("perkmenu_perk_category_" .. string.lower(cat)) or cat, "wOS.GenericMed", mw/2, mh*0.015, Color( 155, 155, 155, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color( 155, 155, 155, 255 ) )
			end
		end
		cppan:SetStartHeight( mh*0.04 )

		local idealsize = #items*( bh + pady )

		local catlist = vgui.Create("DScrollPanel", cppan )
		catlist:SetSize( mw, idealsize )
		catlist:SetPos( 0, mh*0.05 )
		catlist.Paint = function() end
		catlist.VBar.Paint = function() end
		catlist.VBar.btnUp.Paint = function() end
		catlist.VBar.btnDown.Paint = function() end
		catlist.VBar.btnGrip.Paint = function() end

		itemlist:AddItem(cppan)


		for class, data in pairs( items ) do

			local UmbPanel = vgui.Create( "DPanel", catlist )
			UmbPanel:SetPos( 0, offsety )
			UmbPanel:SetSize( bw, bh )
			UmbPanel.Paint = function( pan, ww, hh )
				MENU:LeftStencilCut( ww, hh )
					surface.SetDrawColor( Color( 0, 0, 0, 175 ) )
					surface.DrawRect( 0, 0, ww, hh )
				MENU:EndStencil()
			end

			local Iconent = ClientsideModel("borealis/barrel.mdl")
			Iconent:SetAngles(Angle(0,0,0))
			Iconent:SetPos(Vector(0,0,0))
			Iconent:Spawn()
			Iconent:Activate()

			local uw, uh = UmbPanel:GetSize()
			local ItemIcon = vgui.Create( "DModelPanel", UmbPanel )
			ItemIcon:SetSize( uw*0.25, uh*0.96 )
			ItemIcon:SetPos( uw*0.02, uh*0.02 )
			ItemIcon:SetModel( data.Model )

			Iconent:SetModel( data.Model )
			local center = Iconent:OBBCenter()
			local dist = Iconent:BoundingRadius()*1.6

			ItemIcon:SetLookAt( center )
			ItemIcon:SetCamPos( center + Vector( dist, dist, 0 ) )
			Iconent:Remove()

			if data.Restrictions then
				if not data.Restrictions[ LocalPlayer():GetUserGroup() ] then
					local DataMask = vgui.Create( "DPanel", UmbPanel )
					DataMask:SetSize( uw*0.25, uh*0.96 )
					DataMask:SetPos( uw*0.02, uh*0.02 )
					DataMask.Paint = function( pan, ww, hh )
						draw.SimpleTextOutlined( translate.Get("item_slot_locked"), "wOS.GenericMed", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
					end
				end
			end

			local DataMask = vgui.Create( "DPanel", UmbPanel )
			DataMask:SetSize( uw, uh )
			DataMask.Paint = function( pan, ww, hh )
				draw.SimpleTextOutlined( translate.Get("item_name_" .. data.Name), "wOS.GenericMed", ww*0.27, hh*0.03, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 0, color_white )
				draw.SimpleTextOutlined( translate.Get("item_desc_" .. data.Desc), "wOS.GenericSmall", ww*0.27, hh/2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, color_white )

				if not GAMEMODE.OwnedPerks[ data.ClassName ] then
					draw.SimpleTextOutlined( translate.Format("item_price_x", data.Price), "wOS.GenericSmall", ww*0.27, hh*0.97, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 0, color_white )
				end

				if LocalPlayer().EquippedPerks[1] == data.ClassName or LocalPlayer().EquippedPerks[2] == data.ClassName or LocalPlayer().EquippedPerks[3] == data.ClassName then
					draw.SimpleTextOutlined( translate.Get("perkmenu_perk_equipped"), "wOS.GenericMed", ww*0.93, hh*0.97, Color( 0, 200, 0, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 0, Color( 0, 200, 0, 255 ) )
				end

			end

			offsety = offsety + bh + pady

			if data.Restrictions then
				if not data.Restrictions[ LocalPlayer():GetUserGroup() ] then
					continue
				end
			end

			local ItemButt = vgui.Create( "DButton", UmbPanel )
			ItemButt:SetSize( uw, uh )
			ItemButt:SetText( "" )
			ItemButt.Paint = function( pan, ww, hh )
			end
			ItemButt.DoClick = function( pan )
				if ItemButt.ItemIconOptions then ItemButt.ItemIconOptions:Remove() ItemButt.ItemIconOptions = nil end
				ItemButt.ItemIconOptions = DermaMenu( UmbPanel )
				ItemButt.ItemIconOptions:SetPos( gui.MouseX(), gui.MouseY() )
				ItemButt.ItemIconOptions.Think = function( self )
					if not MENU.LastMerc == "Perks" then self:Remove() end
					if not MENU.MainMerchant then self:Remove() end
					if GetGlobalString("Mode") != "Merchant" and LocalPlayer():Team() == TEAM_HUNK then self:Remove() end
				end
				if not GAMEMODE.OwnedPerks[ data.ClassName ] then
					ItemButt.ItemIconOptions:AddOption( translate.Get("shop_buy_button"), function()
						net.Start( "REGmod.BuyPerk" )
							net.WriteString( data.ClassName, 32 )
						net.SendToServer()
					end )
				else
					if LocalPlayer().EquippedPerks[1] == data.ClassName or LocalPlayer().EquippedPerks[2] == data.ClassName or LocalPlayer().EquippedPerks[3] == data.ClassName then
						ItemButt.ItemIconOptions:AddOption( translate.Get("perkmenu_unequip"), function()
							net.Start( "REGmod.UnequipPerk" )
								net.WriteString( data.ClassName, 32 )
							net.SendToServer()
						end )
					end
					if LocalPlayer().EquippedPerks[1] != data.ClassName then
						ItemButt.ItemIconOptions:AddOption( translate.Get("perkmenu_equip_slot1"), function()
							net.Start( "REGmod.EquipPerk" )
								net.WriteInt( 1, 32 )
								net.WriteString( data.ClassName, 32 )
							net.SendToServer()
						end )
					end
					if LocalPlayer().EquippedPerks[2] != data.ClassName then
						ItemButt.ItemIconOptions:AddOption( translate.Get("perkmenu_equip_slot2"), function()
							net.Start( "REGmod.EquipPerk" )
								net.WriteInt( 2, 32 )
								net.WriteString( data.ClassName, 32 )
							net.SendToServer()
						end )
					end
					if LocalPlayer().EquippedPerks[3] != data.ClassName then
						ItemButt.ItemIconOptions:AddOption( translate.Get("perkmenu_equip_slot3"), function()
							net.Start( "REGmod.EquipPerk" )
								net.WriteInt( 3, 32 )
								net.WriteString( data.ClassName, 32 )
							net.SendToServer()
						end )
					end
				end
			end
		end

	end

	local perkpanel = vgui.Create( "DPanel", self.MerchantFill )
	perkpanel:SetSize( mw, mh*0.08 )
	perkpanel:SetPos( 0, mh*0.02 )
	perkpanel.Paint = function( pan, ww, hh ) end

	local bw, bh = perkpanel:GetSize()
	local padx, pady = bw*0.03, bh*0.02
	local offsetx = 0
	bw = bw*0.30
	bh = bh*0.96
	for slot, item in pairs( LocalPlayer().EquippedPerks ) do
		local data = perky.GetData( item )
		local UmbPanel = vgui.Create( "DPanel", perkpanel )
		UmbPanel:SetPos( offsetx, pady )
		UmbPanel:SetSize( bw, bh )
		UmbPanel.Paint = function( pan, ww, hh )
			MENU:StencilCut( ww, hh )
				surface.SetDrawColor( Color( 0, 0, 0, 175 ) )
				surface.DrawRect( 0, 0, ww, hh )
			MENU:EndStencil()
		end

		local uw, uh = UmbPanel:GetSize()

		local DataMask = vgui.Create( "DPanel", UmbPanel )
		DataMask:SetSize( uw, uh )
		DataMask.Paint = function( pan, ww, hh )
			if data then
				draw.SimpleTextOutlined( translate.Get("item_name_" .. data.Name) or data.Name, "wOS.GenericMed", ww/2, hh*0.1, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 0, color_white )
			else
				draw.SimpleTextOutlined( translate.Get("perkmenu_no_perk"), "wOS.GenericMed", ww/2, hh*0.1, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 0, color_white )
			end
			draw.SimpleTextOutlined( translate.Format("perkmenu_perk_slot_x", slot), "wOS.GenericSmall", ww/2, hh*0.9, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 0, color_white )
		end
		offsetx = offsetx + bw + padx
	end

end

function MENU:MerchantUpgrades()

	self.MerchantFill:Clear()
	local mmw, mmh = self.MainMerchant:GetSize()
	local mw, mh = self.MerchantFill:GetSize()

	local itemlist = vgui.Create("DScrollPanel", self.MerchantFill )
	itemlist:SetSize( mw, mh )
	itemlist.Paint = function() end
	itemlist.VBar.Paint = function() end
	itemlist.VBar.btnUp.Paint = function() end
	itemlist.VBar.btnDown.Paint = function() end
	itemlist.VBar.btnGrip.Paint = function() end

	local items = UPGRADES:GetWeapons( LocalPlayer() )

	local bw, bh = mmw*0.69, mh*0.2
	local padx, pady = mw*0.02, mh*0.02
	local offsety = 0
	local offsetx = padx

	for class, _ in pairs( items ) do
		local data = item.GetItem( class )

		if not data then continue end

		local wupg = data.Upgrades

		local pupg = LocalPlayer().Upgrades[ class ]
		if not wupg then continue end
		if not pupg then continue end

		local UmbPanel = vgui.Create( "DPanel", itemlist )
		UmbPanel:SetPos( 0, offsety )
		UmbPanel:SetSize( bw, bh )
		UmbPanel.Paint = function( pan, ww, hh )
			MENU:LeftStencilCut( ww, hh )
				surface.SetDrawColor( Color( 0, 0, 0, 175 ) )
				surface.DrawRect( 0, 0, ww, hh )
			MENU:EndStencil()
		end

		local Iconent = ClientsideModel("borealis/barrel.mdl")
		Iconent:SetAngles(Angle(0,0,0))
		Iconent:SetPos(Vector(0,0,0))
		Iconent:Spawn()
		Iconent:Activate()

		local uw, uh = UmbPanel:GetSize()
		local ItemIcon = vgui.Create( "DModelPanel", UmbPanel )
		ItemIcon:SetSize( uw*0.25, uh*0.96 )
		ItemIcon:SetPos( uw*0.02, uh*0.02 )
		ItemIcon:SetModel( data.Model )

		Iconent:SetModel( data.Model )
		local center = Iconent:OBBCenter()
		local dist = Iconent:BoundingRadius()*1.6

		ItemIcon:SetLookAt( center )
		ItemIcon:SetCamPos( center + Vector( dist, dist, 0 ) )
		Iconent:Remove()

		if data.Restrictions then
			if not data.Restrictions[ LocalPlayer():GetUserGroup() ] then
				local DataMask = vgui.Create( "DPanel", UmbPanel )
				DataMask:SetSize( uw*0.25, uh*0.96 )
				DataMask:SetPos( uw*0.02, uh*0.02 )
				DataMask.Paint = function( pan, ww, hh )
					draw.SimpleTextOutlined( translate.Get("item_slot_locked"), "wOS.GenericMed", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
				end
			end
		end

		local DataMask = vgui.Create( "DPanel", UmbPanel )
		DataMask:SetSize( uw, uh )
		DataMask.Paint = function( pan, ww, hh )
			draw.SimpleTextOutlined( translate.Get("item_name_" .. data.Name), "wOS.GenericMed", ww*0.27, hh*0.03, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 0, color_white )


			surface.SetFont( "wOS.GenericMed" )
			local tx, ty = surface.GetTextSize( translate.Get("item_name_" .. data.Name) )

			local uposy = hh*0.09 + ty
			local uposx = ww*0.27
			local align = TEXT_ALIGN_LEFT

			for name, level in pairs( pupg ) do
				if not wupg[ name ] then continue end
				surface.SetFont( "wOS.GenericSmall" )
				tx, ty = surface.GetTextSize( "HEIGHT TESTER" )
				if wupg[ name ].MaxLevel then
					if wupg[ name ].MaxLevel <= level then
						draw.SimpleTextOutlined( translate.Format("upgrade_format_max", translate.Get("upgrade_name_" .. string.lower( name )), wupg[ name ].GetDisp( level )), "wOS.GenericSmall", uposx, uposy, color_white, align, TEXT_ALIGN_CENTER, 0, color_white )
						uposy = uposy + hh*0.04 + ty
						continue
					end
				end
				draw.SimpleTextOutlined( translate.Format("upgrade_format", translate.Get("upgrade_name_" .. string.lower( name )), wupg[ name ].GetDisp( level ), level), "wOS.GenericSmall", uposx, uposy, color_white, align, TEXT_ALIGN_CENTER, 0, color_white )
				uposy = uposy + hh*0.04 + ty

				if uposy + ty >= hh then
					surface.SetFont( "wOS.GenericMed" )
					tx, ty = surface.GetTextSize( translate.Get("item_name_" .. data.Name) )
					align = TEXT_ALIGN_RIGHT
					uposy = hh*0.09 + ty
					uposx = ww*0.96
				end

			end

		end

		offsety = offsety + bh + pady

		if data.Restrictions then
			if not data.Restrictions[ LocalPlayer():GetUserGroup() ] then
				continue
			end
		end

		local ItemButt = vgui.Create( "DButton", UmbPanel )
		ItemButt:SetSize( uw, uh )
		ItemButt:SetText( "" )
		ItemButt.Paint = function( pan, ww, hh )
		end
		ItemButt.DoClick = function( pan )
			if ItemButt.ItemIconOptions then ItemButt.ItemIconOptions:Remove() ItemButt.ItemIconOptions = nil end
			ItemButt.ItemIconOptions = DermaMenu( UmbPanel )
			ItemButt.ItemIconOptions:SetPos( gui.MouseX(), gui.MouseY() )
			ItemButt.ItemIconOptions.Think = function( self )
				if not MENU.LastMerc == "Upgrades" then self:Remove() end
				if not MENU.MainMerchant then self:Remove() end
				if GetGlobalString("Mode") != "Merchant" and LocalPlayer():Team() == TEAM_HUNK then self:Remove() end
			end
			for name, dat in pairs( wupg ) do
				local level = pupg[ name ]
				if not level then continue end
				if dat.MaxLevel then
					if dat.MaxLevel <= level then continue end
				end

				ItemButt.ItemIconOptions:AddOption( translate.Format("upgrade_button", translate.Get("upgrade_name_" .. string.lower( name ) ), dat.GetCost( level ) ), function()
					net.Start( "REGmod.BuyUpgrade" )
						net.WriteString( class, 32 )
						net.WriteString( name, 32 )
					net.SendToServer()
				end )

			end
		end
	end

end


function MENU:MerchantPlayerModel()
	self.MerchantFill:Clear()
	local mmw, mmh = self.MainMerchant:GetSize()
	local mw, mh = self.MerchantFill:GetSize()




	local itemlist = vgui.Create( "DPanelList", self.MerchantFill )
	itemlist:SetSize( mw, mh )
	itemlist:SetSpacing( mh*0.02 )
	itemlist:EnableVerticalScrollbar(true)
	itemlist.VBar.Paint = function() end
	itemlist.VBar.btnUp.Paint = function() end
	itemlist.VBar.btnDown.Paint = function() end
	itemlist.VBar.btnGrip.Paint = function() end
	itemlist.Paint = function() end

	local cats = damodels.GetCategories()


	for cat, _ in pairs( cats ) do
		local items = damodels.GetCategoryItems( cat )
		local bw, bh = mw*0.2, mh*0.2
		local padx, pady = mw*0.02, mh*0.02
		local offsety = 0
		local offsetx = padx

		local cppan = vgui.Create("DCollapsibleCategory", itemlist )
		cppan:SetSize( mmw*0.71, mh*0.1 )
		cppan:SetExpanded( true )
		cppan:SetLabel("")
		cppan.Paint = function(pan, ww, hh)
			pan.OldHeight = mh*0.04
			MENU:TopLeftStencilCut( mmw*0.69, mh*0.04 )
				surface.SetDrawColor( Color( 255, 255, 255, 125 ) )
				surface.DrawRect( 0, 0, mmw*0.69, mh*0.04 )
			MENU:EndStencil()
			if cppan:GetExpanded() then
				draw.SimpleTextOutlined( translate.Get("playermodels_model_category_" .. string.lower(cat)) or cat, "wOS.GenericMed", mw/2, mh*0.015, color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_black )
			else
				draw.SimpleTextOutlined( translate.Get("playermodels_model_category_" .. string.lower(cat)) or cat, "wOS.GenericMed", mw/2, mh*0.015, Color( 155, 155, 155, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color( 155, 155, 155, 255 ) )
			end
		end
		cppan:SetStartHeight( mh*0.04 )

		local idealsize = ( math.ceil( #items/4 ) )*( bh + padx )

		local catlist = vgui.Create("DScrollPanel", cppan )
		catlist:SetSize( mw, idealsize )
		catlist:SetPos( 0, mh*0.05 )
		catlist.Paint = function() end
		catlist.VBar.Paint = function() end
		catlist.VBar.btnUp.Paint = function() end
		catlist.VBar.btnDown.Paint = function() end
		catlist.VBar.btnGrip.Paint = function() end

		itemlist:AddItem(cppan)

		for class, data in pairs( items ) do

			if offsetx + bw >= mw then
				offsetx = padx
				offsety = offsety + pady + bh
			end

			local UmbPanel = vgui.Create( "DPanel", catlist )
			UmbPanel:SetPos( offsetx, offsety )
			UmbPanel:SetSize( bw, bh )
			UmbPanel.Paint = function( pan, ww, hh )
				MENU:LargeStencilCut( ww, hh )
					surface.SetDrawColor( Color( 0, 0, 0, 175 ) )
					surface.DrawRect( 0, 0, ww, hh )
				MENU:EndStencil()
			end

			local Iconent = ClientsideModel("borealis/barrel.mdl")
			Iconent:SetAngles(Angle(0,0,0))
			Iconent:SetPos(Vector(0,0,0))
			Iconent:Spawn()
			Iconent:Activate()

			local uw, uh = UmbPanel:GetSize()
			local ItemIcon = vgui.Create( "DModelPanel", UmbPanel )
			ItemIcon:SetSize( uw*2, uh*2 )
			ItemIcon:SetPos( uw*-0.5, uh*-0.2 )
			ItemIcon:SetModel( data.Model )

			Iconent:SetModel( data.Model )
			local center = Iconent:OBBCenter()
			local dist = Iconent:BoundingRadius()*1.6

			ItemIcon:SetLookAt( center )
			ItemIcon:SetCamPos( center + Vector( dist, dist, 0 ) )
			Iconent:Remove()

			local DataMask = vgui.Create( "DPanel", UmbPanel )
			DataMask:SetSize( uw, uh )
			DataMask.Paint = function( pan, ww, hh )

				if data.Restrictions then
					if not data.Restrictions[ LocalPlayer():GetUserGroup() ] then
						draw.SimpleTextOutlined( translate.Get("playermodels_model_locked"), "wOS.GenericMed", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
						return
					end
				end

				if not GAMEMODE.OwnedModels[ data.ClassName ] then
					draw.SimpleTextOutlined( translate.Format("item_price_x", data.Price), "wOS.GenericSmall", ww/2, hh*0.97, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 0, color_white )
				end

				if LocalPlayer().EquippedModel == data.ClassName then
					draw.SimpleTextOutlined( translate.Get("playermodels_model_equipped"), "wOS.GenericMed", ww/2, hh/2, Color(0,255,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
				end
				draw.SimpleTextOutlined( translate.Get("model_name_" .. string.lower(data.Name) ), "wOS.GenericSmall", ww/2, hh*0.03, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 0, color_white )
				if GAMEMODE.OwnedModels[ data.ClassName ] then
					if LocalPlayer().EquippedModel == data.ClassName then return end
				draw.SimpleTextOutlined( translate.Get("playermodels_model_owned"), "wOS.GenericSmall", ww/2, hh*0.97, Color(0,255,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 0, color_white )
			end
			end

			offsetx = offsetx + bw + padx

			if data.Restrictions then
				if not data.Restrictions[ LocalPlayer():GetUserGroup() ] then
					continue
				end
			end

			local ItemButt = vgui.Create( "DButton", UmbPanel )
			ItemButt:SetSize( uw, uh )
			ItemButt:SetText( "" )
			ItemButt.Paint = function( pan, ww, hh )
			end
			ItemButt.DoClick = function( pan )
				if ItemButt.ItemIconOptions then ItemButt.ItemIconOptions:Remove() ItemButt.ItemIconOptions = nil end
				ItemButt.ItemIconOptions = DermaMenu( UmbPanel )
				ItemButt.ItemIconOptions:SetPos( gui.MouseX(), gui.MouseY() )
				ItemButt.ItemIconOptions.Think = function( self )
					if not MENU.LastMerc == "PlayerModels" then self:Remove() end
					if not MENU.MainMerchant then self:Remove() end
					if GetGlobalString("Mode") != "Merchant" and LocalPlayer():Team() == TEAM_HUNK then self:Remove() end
				end




				local ownmdls = {}
				for mdl, _ in pairs( GAMEMODE.OwnedModels ) do
					table.insert( ownmdls, mdl )
				end
				if !table.HasValue(ownmdls,data.ClassName) then
					ItemButt.ItemIconOptions:AddOption( translate.Get("shop_buy_button"), function()
						net.Start( "REGmod.BuyModel" )
						net.WriteString( data.ClassName, 32 )
						net.SendToServer()
					end )

				else
					if LocalPlayer().EquippedModel == data.ClassName then
						ItemButt.ItemIconOptions:AddOption( translate.Get("playermodels_unequip_button"), function()
							thisismodelon = false
							net.Start( "REGmod.UnequipModel" )
								net.WriteString( data.ClassName, 32 )

							net.SendToServer()
						end )
					end
					if LocalPlayer().EquippedModel != data.ClassName then
						ItemButt.ItemIconOptions:AddOption( translate.Get("playermodels_equip_button"), function()
							print("equip model")
							thisismodelon = true
							net.Start( "REGmod.EquipModel" )
								net.WriteString( data.ClassName, 32 )
								
							net.SendToServer()
						end )
					end
				end
				ItemButt.ItemIconOptions:AddOption( translate.Get("playermodels_preview_button"), function()
					local PreviewModelPanel = vgui.Create( "DPanel", catlist )
								PreviewModelPanel:SetPos( uw/2, uh/2.5 )
								PreviewModelPanel:SetSize( uw, uh )
								PreviewModelPanel:Center()
								PreviewModelPanel.Paint = function(self,w,h)
															surface.SetDrawColor( Color(255,255,255,0) )
															surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
														--	PreviewModelPanel.Paint(self, w, h)
														end

								Previewmdl = vgui.Create( "DModelPanel", PreviewModelPanel )
								Previewmdl:SetSize( PreviewModelPanel:GetWide(), PreviewModelPanel:GetTall() )
								Previewmdl:SetModel( data.Model )
								if data.Model == "models/mark2580/resident2/moira_prisoner_player.mdl" then
									Previewmdl:SetSkin(1)
								end
								Previewmdl.DoClick = function()
									PreviewModelPanel:Remove()
								end
				end )
		end

	end





	end
end
