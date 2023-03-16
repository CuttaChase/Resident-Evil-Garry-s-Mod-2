if not MENU then MENU = {} end

local origin = Vector(0, 0, 0)
local angle = Vector(0, 0, 0)
local normal = Vector(0, 0, 0)
local scale = 0

-- Helper functions

local function getCursorPos( pnl )
	return gui.MousePos()
end

local function getCursorCrePos()
	local p = util.IntersectRayWithPlane(LocalPlayer():EyePos(), LocalPlayer():GetAimVector(), origin, normal)

	-- if there wasn't an intersection, don't calculate anything.
	if not p then return 0, 0 end

	local offset = origin - p
	
	local angle2 = angle:Angle()
	angle2:RotateAroundAxis( normal, 90 )
	angle2 = angle2:Forward()
	
	local offsetp = Vector(offset.x, offset.y, offset.z)
	offsetp:Rotate(-normal:Angle())

    local x = -offsetp.y
    local y = offsetp.z

	return x, y
end

local function getParents( pnl )
	local parents = {}
	local parent = pnl.Parent
	while ( parent ) do
		table.insert( parents, parent )
		parent = parent.Parent
	end
	return parents
end

local function absolutePanelPos( pnl )
	local x, y = pnl:GetPos()
	local parents = getParents( pnl )
	for _, parent in ipairs( parents ) do
		local px, py = parent:GetPos()
		x = x + px
		y = y + py
	end
	return x, y
end

local function pointInsidePanel( pnl, x, y )
	local px, py = absolutePanelPos( pnl )
	local sx, sy = pnl:GetSize()

	local origs = pnl:GetOrigins():ToScreen()
	
	px = px + origs.x
	py = py + origs.y
	--[[
	print( "Min X: " .. px )
	print( "Min Y: " .. py )
	print( "Max X: " .. px + sx )
	print( "Max Y: " .. py + sy )	
	print( "-----------------------" )
	print( "Position: ( " .. x .. ", " .. y .. " )" )
	print( "------------------------------------------------------------" )
	]]--
	return x >= px and y >= py and x <= px + sx and y <= py + sy
end

-- Input

inputWindows = {}

local function isMouseOver( pnl )
	return pointInsidePanel( pnl, getCursorPos( pnl ) )
end

local function postPanelEvent( pnl, event, ... )
	if ( not pnl:IsValid() or not pointInsidePanel( pnl, getCursorPos( pnl ) ) ) then return false end
	
	local handled = false
	
	for child in pairs( pnl.Childs or {} ) do
		if ( postPanelEvent( child, event, ... ) ) then
			handled = true
			break
		end
	end
	
	if ( not handled and pnl[ event ] ) then
		pnl[ event ]( pnl, ... )
		return true
	else
		return false
	end
end

local function checkHover( pnl, x, y )
	if not (x and y) then
		x,y=getCursorPos( pnl )
	end
	pnl.WasHovered = pnl.Hovered
	pnl.Hovered = pointInsidePanel( pnl, x, y )
	
	if not pnl.WasHovered and pnl.Hovered then
		if pnl.OnCursorEntered then pnl:OnCursorEntered() end
	elseif pnl.WasHovered and not pnl.Hovered then
		if pnl.OnCursorExited then pnl:OnCursorExited() end
	end
	
	for child, _ in pairs( pnl.Childs or {} ) do
		if ( child:IsValid() and child:IsVisible() ) then checkHover( child, x, y ) end
	end
end

function vgui.Start3D2D( pos, ang, res )
	origin = pos
	scale = res
	angle = ang:Forward()
	
	normal = Angle( ang.p, ang.y, ang.r )
	normal:RotateAroundAxis( ang:Forward(), -90 )
	normal:RotateAroundAxis( ang:Right(), 90 )
	normal = normal:Forward()
	
	cam.Start3D2D( pos, ang, res )
	cam.IgnoreZ(true)
	
end

local _R = debug.getregistry()
function _R.Panel:Paint3D2D()
	if not self:IsValid() then return end
	
	-- Add it to the list of windows to receive input
	inputWindows[ self ] = true


	local cx, cy = getCursorCrePos()

	
	self.Origin = origin
	self.Scale = scale
	self.Angle = angle
	self.Normal = normal
	
	-- Override think of DFrame's to correct the mouse pos by changing the active orientation
	if self.Think then
		if not self.OThink then
			self.OThink = self.Think
			
			self.Think = function()
				origin = self.Origin
				scale = self.Scale
				angle = self.Angle
				normal = self.Normal
				
				self:OThink()
			end
		end
	end
	
	-- Update the hover state of controls
	checkHover( self )
	
	-- Draw it manually
	self:SetPaintedManually( false )
		self:PaintManual()
	self:SetPaintedManually( true )

end

function vgui.End3D2D()
	cam.End3D2D()
end

-- Keep track of child controls

if not vguiCreate then vguiCreate = vgui.Create end
function vgui.Create( class, parent )
	local pnl = vguiCreate( class, parent )
	if not pnl then return end
	
	pnl.Parent = parent
	pnl.Class = class
	
	if parent and type(parent) == "Panel" and IsValid(parent) then
		if not parent.Childs then parent.Childs = {} end
		parent.Childs[ pnl ] = true
		pnl.Origin = parent.Origin
		pnl.GetOrigins = parent.GetOrigins
	end
	return pnl
end

hook.Add( "Think", "VGUI3D2DMouseDetour", function()

	if GAMEMODE.InMenu then
	
		if input.IsMouseDown( MOUSE_LEFT ) then
			if MENU.InputLeftDelay > CurTime() then return end
			
			MENU.InputLeftDelay = CurTime() + 0.2
			for pnl in pairs( inputWindows ) do
					if ( pnl:IsValid() ) then
						origin = pnl.Origin
						scale = pnl.Scale
						angle = pnl.Angle
						normal = pnl.Normal
						
						postPanelEvent( pnl, "OnMousePressed", MOUSE_LEFT )
						return
					end
				end
			end
		if input.IsMouseDown( MOUSE_RIGHT ) then
			if MENU.InputRightDelay > CurTime() then return end
			MENU.InputRightDelay = CurTime() + 0.2
			for pnl in pairs( inputWindows ) do
					if ( pnl:IsValid() ) then
						origin = pnl.Origin
						scale = pnl.Scale
						angle = pnl.Angle
						normal = pnl.Normal
						
						postPanelEvent( pnl, "OnMousePressed", MOUSE_RIGHT )
						return
					end
				end
		end
	end
end )
