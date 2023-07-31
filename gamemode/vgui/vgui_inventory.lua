local w,h = ScrW(), ScrH()

local maincolor = Color( 125, 0, 0, 225 )

if not MENU then MENU = {} end

function MENU:OpenInventory()

	if self.Inventory then
		if self.Inventory:IsVisible() then return end
	end
	if self.MainMerchant then return end

	gui.EnableScreenClicker( true )
	self.Inventory = vgui.Create("DPanel")
	self.Inventory:SetSize( w*0.125, h*0.5 )
	--self.Inventory:SetPos( w*0.5, h*0.3 )
	self.Inventory:Center()
	self.Inventory.LastPos = self.Inventory:GetPos()
	self.Inventory.Paint = function( pan, ww, hh )
		if LocalPlayer().CamSwap then
			local posx = Lerp( 0.05, pan.LastPos, w*0.4 )
			pan:SetPos( posx, h*0.3 )
		else
			local posx = Lerp( 0.05, pan.LastPos, w*0.5 )
			pan:SetPos( posx, h*0.3 )
		end
		MENU:LargeStencilCut( ww, hh )
			surface.SetDrawColor( maincolor )
			surface.DrawRect( 0, 0, ww, hh )
		MENU:EndStencil()

		surface.SetDrawColor( color_white )
		surface.DrawLine( ww/2, hh*0.08, ww/2, hh*0.92 )
	end

	local mw, mh = self.Inventory:GetSize()

	self.InventoryLeft = vgui.Create( "DPanel", self.Inventory )
	self.InventoryLeft:SetSize( mw/2, mh )
	self.InventoryLeft:SetPos( 0, 0 )
	self.InventoryLeft.Paint = function( pan, ww, hh )
	end

	self.InventoryRight = vgui.Create( "DPanel", self.Inventory )
	self.InventoryRight:SetSize( mw/2, mh )
	self.InventoryRight:SetPos( mw/2, 0 )
	self.InventoryRight.Paint = function( pan, ww, hh )
	end

	self:ReloadInventory()

	if GetGlobalString("Mode") == "Merchant" || LocalPlayer():Team() != TEAM_HUNK then
		local EnterMerc = vgui.Create( "DButton", self.Inventory )
		EnterMerc:SetPos( 0, mh*0.92 )
		EnterMerc:SetSize( mw, mh*0.08 )
		EnterMerc:SetText("")
		EnterMerc.Paint = function( pan, ww, hh )
			if EnterMerc:IsHovered() then
				draw.SimpleTextOutlined( translate.Get("inventory_open_shop"), "wOS.GenericMed", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
			else
				draw.SimpleTextOutlined( translate.Get("inventory_open_shop"), "wOS.GenericMed", ww/2, hh/2, Color( 155, 155, 155, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color( 155, 155, 155, 255 ) )
			end
		end
		EnterMerc.DoClick = function(EnterMerc)
			net.Start( "REGmod.OpenMerchant" )
			net.SendToServer()
			MENU:CloseInventory()
		end
	end

end

function MENU:ReloadInventory()

	local mw, mh = self.Inventory:GetSize()
	local bw, bh = self.InventoryLeft:GetSize()
	local offsety = bh*0.1
	local padx, pady = bw*0.05, bh*0.02

	self.InventoryLeft:Clear()
	self.InventoryRight:Clear()

	for i = 1, 10 do
		local UmbPanel
		local flipset = false
		if i%2 == 0 then
			UmbPanel = vgui.Create( "DPanel", self.InventoryRight )
			flipset = true
		else
			UmbPanel = vgui.Create( "DPanel", self.InventoryLeft )
		end
		UmbPanel:SetPos( padx, offsety*.85 )
		UmbPanel:SetSize( bw - 2*padx, bh*0.14 )
		UmbPanel.Paint = function( pan, ww, hh )
			if flipset then
				MENU:LargeLeftStencilCut( ww, hh )
			else
				MENU:LargeRightStencilCut( ww, hh )
			end
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

		if not LocalPlayer().inventory[ i ] then
			if flipset then
				offsety = offsety + bh*0.185 + pady
			end
			continue
		end

		if LocalPlayer().inventory[ i ].Item == 0 then
			if flipset then
				offsety = offsety + bh*0.185 + pady
			end
			continue
		end

		local Iconent = ClientsideModel("borealis/barrel.mdl")
		Iconent:SetAngles(Angle(0,0,0))
		Iconent:SetPos(Vector(0,0,0))
		Iconent:Spawn()
		Iconent:Activate()

		local uw, uh = UmbPanel:GetSize()

		local data = item.GetItem( LocalPlayer().inventory[ i ].Item )

		local ItemIcon = vgui.Create( "DModelPanel", UmbPanel )
		ItemIcon:SetSize( uw, uh )
		ItemIcon:SetModel( data.Model )

		Iconent:SetModel( data.Model )
		local center = Iconent:OBBCenter()
		local dist = Iconent:BoundingRadius()*1.6

		ItemIcon:SetLookAt( center )
		ItemIcon:SetCamPos( center + Vector( dist, dist, 0 ) )

		local ItemButt = vgui.Create( "DButton", UmbPanel )
		ItemButt:SetSize( uw, uh )
		ItemButt:SetText( "" )
		ItemButt.Slot = i
		ItemButt.Paint = function( pan, ww, hh )
			draw.SimpleTextOutlined( translate.Format("item_slot_x", ItemButt.Slot), "wOS.GenericSmall", ww/2, hh*0.98, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 0, color_white )
			if LocalPlayer().inventory[ i ].Amount > 1 then
				if flipset then
					draw.SimpleTextOutlined( "x" .. LocalPlayer().inventory[ ItemButt.Slot ].Amount, "wOS.GenericSmall", ww*0.05, hh*0.02, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 0, color_white )
				else
					draw.SimpleTextOutlined( "x" .. LocalPlayer().inventory[ ItemButt.Slot ].Amount, "wOS.GenericSmall", ww*0.95, hh*0.02, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 0, color_white )
				end
			end
		end
		ItemButt.DoClick = function( pan )
			net.Start( "REGmod.UseItem" )
				net.WriteString( data.ClassName, 32 )
				net.WriteInt( ItemButt.Slot, 32 )
			net.SendToServer()
			self:ReloadInventory()
		end
		ItemButt.PreOffset = offsety
		ItemButt.Think = function( pan )
			if not ItemButt:IsHovered() then
				if ItemButt.ItemContext then
					ItemButt.ItemContext = nil
				end
				return
			end
			if ItemButt.ItemContext then return end
			ItemButt.ItemContext = vgui.Create( "DPanel" )
			local posx, posy = MENU.Inventory:GetPos()
			local possx, possy = UmbPanel:GetSize()
			ItemButt.ItemContext:SetPos( posx + mw, posy + ItemButt.PreOffset + bh*0.0925*0.5 )
			ItemButt.ItemContext:SetSize( w*0.1, bh*0.0925 )
			ItemButt.ItemContext.Paint = function( pan, ww, hh )
				MENU:LargeStencilCut( ww, hh )
					surface.SetDrawColor( maincolor )
					surface.DrawRect( 0, 0, ww, hh )
				MENU:EndStencil()
				draw.SimpleTextOutlined( translate.Get("item_name_" .. data.Name), "wOS.GenericMed", ww/2, hh*0.15, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 0, color_white )
				draw.SimpleTextOutlined( translate.Get("item_desc_" .. data.Desc), "wOS.GenericSmall", ww/2, hh*0.55, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 0, color_white )

			end
			ItemButt.ItemContext.Think = function( self )
				if not MENU.Inventory then self:Remove() end
				if not ItemButt:IsHovered() then self:Remove() end
			end
		end
		ItemButt.DoRightClick = function( pan )
			ItemButt.ItemIconOptions = DermaMenu( UmbPanel )
			ItemButt.ItemIconOptions:SetPos( gui.MouseX(), gui.MouseY() )
			ItemButt.ItemIconOptions.Think = function( self )
				if not MENU.Inventory then self:Remove() end
			end
			ItemButt.ItemIconOptions:AddOption( translate.Get("use"), function()
				net.Start( "REGmod.UseItem" )
					net.WriteString( data.ClassName, 32 )
					net.WriteInt( ItemButt.Slot, 32 )
				net.SendToServer()
				ItemButt.ItemIconOptions:Remove()
				self:ReloadInventory()
			end )

			ItemButt.ItemIconOptions:AddOption( translate.Get("give"), function()
				net.Start( "REGmod.GiveItem" )
					net.WriteString( data.ClassName, 32 )
					net.WriteInt( ItemButt.Slot, 32 )
				net.SendToServer()
				ItemButt.ItemIconOptions:Remove()
				self:ReloadInventory()
			end )

			if data.CustomOptions then
				for name, _ in pairs( data.CustomOptions ) do
					ItemButt.ItemIconOptions:AddOption( name, function()
						net.Start( "REGmod.CustomItemOption" )
							net.WriteString( data.ClassName, 32 )
							net.WriteString( name, 32 )
							net.WriteInt( ItemButt.Slot, 32 )
						net.SendToServer()
						ItemButt.ItemIconOptions:Remove()
						self:ReloadInventory()
					end )
				end
			end

			ItemButt.ItemIconOptions:AddOption( translate.Get("drop"), function()
				net.Start( "REGmod.DropItem" )
					net.WriteString( data.ClassName, 32 )
					net.WriteInt( ItemButt.Slot, 32 )
				net.SendToServer()
				ItemButt.ItemIconOptions:Remove()
				self:ReloadInventory()
			end )

		end

		if flipset then
			offsety = offsety + bh*0.185 + pady
		end

		Iconent:Remove()

	end

end

function MENU:CloseInventory()

	if not self.Inventory then return end

	self.Inventory:Remove()
	self.Inventory = nil

	if self.MainMerchant then return end
	gui.EnableScreenClicker( false )

end
