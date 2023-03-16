local w,h = ScrW(), ScrH()

surface.CreateFont("wOS.GenericSmall", {
	size = 16*(ScrH()/1200),
	weight = 400,
	antialias = true,
	shadow = false,
	font =  "Arial"})

surface.CreateFont("wOS.GenericMed", {
	size = 24*(ScrH()/1200),
	weight = 400,
	antialias = true,
	shadow = false,
	font = "Arial"})
	
surface.CreateFont("wOS.GenericLarge", {
	size = 38*(ScrH()/1200),
	weight = 400,
	antialias = true,
	shadow = false,
	font = "Arial"})

local w,h = ScrW(), ScrH()
local PLAYER = LocalPlayer()

function MENU:StencilCut( ww, hh, sw, sh )

			if not sw then sw = 0 end
			if not sh then sh = 0 end
			
			local InfoBarFrame = {
				{ x = sw + ww*0.01, y = sh + hh*(3/4)},
				{ x = sw + ww*0.01, y = sh + hh*(1/4)},
				{ x = sw + ww*0.05, y = sh},
				{ x = sw + ww*0.95, y = sh},
				{ x = sw + ww*0.99, y = sh + hh*(1/4) },
				{ x = sw + ww*0.99, y = sh + hh*(3/4) },
				{ x = sw + ww*0.95, y = sh + hh },
				{ x = sw + ww*0.05, y = sh + hh }
			}
			render.ClearStencil() --Clear stencil
			render.SetStencilEnable( true ) --Enable stencil
			render.SetStencilWriteMask(1)
			render.SetStencilTestMask(1)
			render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER);
			render.SetStencilFailOperation(STENCILOPERATION_DECR);
			render.SetStencilZFailOperation(STENCILOPERATION_DECR );
			render.SetStencilPassOperation( STENCILOPERATION_DECR ) 
			render.SetStencilReferenceValue( 1 )
			render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_EQUAL )
			surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
			surface.DrawPoly( InfoBarFrame )

end

function MENU:LeftStencilCut( ww, hh, sw, sh )

			if not sw then sw = 0 end
			if not sh then sh = 0 end
			
			local InfoBarFrame = {
				{ x = sw + ww*0.01, y = sh + hh },
				{ x = sw + ww*0.01, y = sh },
				{ x = sw + ww*0.95, y = sh },
				{ x = sw + ww*0.99, y = sh + hh*(1/4) },
				{ x = sw + ww*0.99, y = sh + hh*(3/4) },
				{ x = sw + ww*0.95, y = sh + hh }
			}
			render.ClearStencil() --Clear stencil
			render.SetStencilEnable( true ) --Enable stencil
			render.SetStencilWriteMask(1)
			render.SetStencilTestMask(1)
			render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER);
			render.SetStencilFailOperation(STENCILOPERATION_DECR);
			render.SetStencilZFailOperation(STENCILOPERATION_DECR );
			render.SetStencilPassOperation( STENCILOPERATION_DECR ) 
			render.SetStencilReferenceValue( 1 )
			render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_EQUAL )
			surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
			surface.DrawPoly( InfoBarFrame )

end

function MENU:RightStencilCut( ww, hh, sw, sh )

			if not sw then sw = 0 end
			if not sh then sh = 0 end
			
			local InfoBarFrame = {
				{ x = sw + ww*0.01, y = sh + hh*(3/4)},
				{ x = sw + ww*0.01, y = sh + hh*(1/4)},
				{ x = sw + ww*0.05, y = sh },
				{ x = sw + ww*0.99, y = sh },
				{ x = sw + ww*0.99, y = sh + hh },
				{ x = sw + ww*0.05, y = sh + hh }
			}
			render.ClearStencil() --Clear stencil
			render.SetStencilEnable( true ) --Enable stencil
			render.SetStencilWriteMask(1)
			render.SetStencilTestMask(1)
			render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER);
			render.SetStencilFailOperation(STENCILOPERATION_DECR);
			render.SetStencilZFailOperation(STENCILOPERATION_DECR );
			render.SetStencilPassOperation( STENCILOPERATION_DECR ) 
			render.SetStencilReferenceValue( 1 )
			render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_EQUAL )
			surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
			surface.DrawPoly( InfoBarFrame )

end

function MENU:BottomStencilCut( ww, hh, sw, sh )

			if not sw then sw = 0 end
			if not sh then sh = 0 end
			
			local InfoBarFrame = {
				{ x = sw + ww*0.01, y = sh + hh*(3/4)},
				{ x = sw + ww*0.01, y = sh},
				{ x = sw + ww*0.99, y = sh},
				{ x = sw + ww*0.99, y = sh + hh*(3/4) },
				{ x = sw + ww*0.95, y = sh + hh },
				{ x = sw + ww*0.05, y = sh + hh }
			}
			render.ClearStencil() --Clear stencil
			render.SetStencilEnable( true ) --Enable stencil
			render.SetStencilWriteMask(1)
			render.SetStencilTestMask(1)
			render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER);
			render.SetStencilFailOperation(STENCILOPERATION_DECR);
			render.SetStencilZFailOperation(STENCILOPERATION_DECR );
			render.SetStencilPassOperation( STENCILOPERATION_DECR ) 
			render.SetStencilReferenceValue( 1 )
			render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_EQUAL )
			surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
			surface.DrawPoly( InfoBarFrame )

end

function MENU:TopStencilCut( ww, hh, sw, sh )

			if not sw then sw = 0 end
			if not sh then sh = 0 end
			
			local InfoBarFrame = {
				{ x = sw + ww*0.01, y = sh + hh*(3/4)},
				{ x = sw + ww*0.05, y = sh},
				{ x = sw + ww*0.95, y = sh},
				{ x = sw + ww*0.99, y = sh + hh*(3/4) },
				{ x = sw + ww*0.99, y = sh + hh },
				{ x = sw + ww*0.01, y = sh + hh }
			}
			render.ClearStencil() --Clear stencil
			render.SetStencilEnable( true ) --Enable stencil
			render.SetStencilWriteMask(1)
			render.SetStencilTestMask(1)
			render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER);
			render.SetStencilFailOperation(STENCILOPERATION_DECR);
			render.SetStencilZFailOperation(STENCILOPERATION_DECR );
			render.SetStencilPassOperation( STENCILOPERATION_DECR ) 
			render.SetStencilReferenceValue( 1 )
			render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_EQUAL )
			surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
			surface.DrawPoly( InfoBarFrame )

end

function MENU:TopLeftStencilCut( ww, hh, sw, sh )

			if not sw then sw = 0 end
			if not sh then sh = 0 end
			
			local InfoBarFrame = {
				{ x = sw + ww*0.01, y = sh},
				{ x = sw + ww*0.95, y = sh},
				{ x = sw + ww*0.99, y = sh + hh*(3/4) },
				{ x = sw + ww*0.99, y = sh + hh },
				{ x = sw + ww*0.01, y = sh + hh }
			}
			render.ClearStencil() --Clear stencil
			render.SetStencilEnable( true ) --Enable stencil
			render.SetStencilWriteMask(1)
			render.SetStencilTestMask(1)
			render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER);
			render.SetStencilFailOperation(STENCILOPERATION_DECR);
			render.SetStencilZFailOperation(STENCILOPERATION_DECR );
			render.SetStencilPassOperation( STENCILOPERATION_DECR ) 
			render.SetStencilReferenceValue( 1 )
			render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_EQUAL )
			surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
			surface.DrawPoly( InfoBarFrame )

end

------------------------------

function MENU:LargeStencilCut( ww, hh, sw, sh )

			if not sw then sw = 0 end
			if not sh then sh = 0 end
			
			local InfoBarFrame = {
				{ x = sw + ww*0.01, y = sh + hh*(19/20)},
				{ x = sw + ww*0.01, y = sh + hh*(1/20)},
				{ x = sw + ww*0.05, y = sh},
				{ x = sw + ww*0.95, y = sh},
				{ x = sw + ww*0.99, y = sh + hh*(1/20) },
				{ x = sw + ww*0.99, y = sh + hh*(19/20) },
				{ x = sw + ww*0.95, y = sh + hh },
				{ x = sw + ww*0.05, y = sh + hh }
			}
			render.ClearStencil() --Clear stencil
			render.SetStencilEnable( true ) --Enable stencil
			render.SetStencilWriteMask(1)
			render.SetStencilTestMask(1)
			render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER);
			render.SetStencilFailOperation(STENCILOPERATION_DECR);
			render.SetStencilZFailOperation(STENCILOPERATION_DECR );
			render.SetStencilPassOperation( STENCILOPERATION_DECR ) 
			render.SetStencilReferenceValue( 1 )
			render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_EQUAL )
			surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
			surface.DrawPoly( InfoBarFrame )

end

function MENU:LargeBottomStencilCut( ww, hh, sw, sh )

			if not sw then sw = 0 end
			if not sh then sh = 0 end
			
			local InfoBarFrame = {
				{ x = sw + ww*0.01, y = sh + hh*(19/20)},
				{ x = sw + ww*0.01, y = sh},
				{ x = sw + ww*0.99, y = sh},
				{ x = sw + ww*0.99, y = sh + hh*(19/20) },
				{ x = sw + ww*0.95, y = sh + hh },
				{ x = sw + ww*0.05, y = sh + hh }
			}
			render.ClearStencil() --Clear stencil
			render.SetStencilEnable( true ) --Enable stencil
			render.SetStencilWriteMask(1)
			render.SetStencilTestMask(1)
			render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER);
			render.SetStencilFailOperation(STENCILOPERATION_DECR);
			render.SetStencilZFailOperation(STENCILOPERATION_DECR );
			render.SetStencilPassOperation( STENCILOPERATION_DECR ) 
			render.SetStencilReferenceValue( 1 )
			render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_EQUAL )
			surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
			surface.DrawPoly( InfoBarFrame )

end

function MENU:LargeTopStencilCut( ww, hh, sw, sh )

			if not sw then sw = 0 end
			if not sh then sh = 0 end
			
			local InfoBarFrame = {
				{ x = sw + ww*0.01, y = sh + hh*(19/20)},
				{ x = sw + ww*0.05, y = sh},
				{ x = sw + ww*0.95, y = sh},
				{ x = sw + ww*0.99, y = sh + hh*(19/20) },
				{ x = sw + ww*0.99, y = sh + hh },
				{ x = sw + ww*0.01, y = sh + hh }
			}
			render.ClearStencil() --Clear stencil
			render.SetStencilEnable( true ) --Enable stencil
			render.SetStencilWriteMask(1)
			render.SetStencilTestMask(1)
			render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER);
			render.SetStencilFailOperation(STENCILOPERATION_DECR);
			render.SetStencilZFailOperation(STENCILOPERATION_DECR );
			render.SetStencilPassOperation( STENCILOPERATION_DECR ) 
			render.SetStencilReferenceValue( 1 )
			render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_EQUAL )
			surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
			surface.DrawPoly( InfoBarFrame )

end

function MENU:LargeLeftStencilCut( ww, hh, sw, sh )

			if not sw then sw = 0 end
			if not sh then sh = 0 end
			
			local InfoBarFrame = {
				{ x = sw + ww*0.01, y = sh + hh },
				{ x = sw + ww*0.01, y = sh },
				{ x = sw + ww*0.95, y = sh },
				{ x = sw + ww*0.99, y = sh + hh*(1/20) },
				{ x = sw + ww*0.99, y = sh + hh*(19/20) },
				{ x = sw + ww*0.95, y = sh + hh }
			}
			render.ClearStencil() --Clear stencil
			render.SetStencilEnable( true ) --Enable stencil
			render.SetStencilWriteMask(1)
			render.SetStencilTestMask(1)
			render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER);
			render.SetStencilFailOperation(STENCILOPERATION_DECR);
			render.SetStencilZFailOperation(STENCILOPERATION_DECR );
			render.SetStencilPassOperation( STENCILOPERATION_DECR ) 
			render.SetStencilReferenceValue( 1 )
			render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_EQUAL )
			surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
			surface.DrawPoly( InfoBarFrame )

end

function MENU:LargeRightStencilCut( ww, hh, sw, sh )

			if not sw then sw = 0 end
			if not sh then sh = 0 end
			
			local InfoBarFrame = {
				{ x = sw + ww*0.01, y = sh + hh*(19/20)},
				{ x = sw + ww*0.01, y = sh + hh*(1/20)},
				{ x = sw + ww*0.05, y = sh },
				{ x = sw + ww*0.99, y = sh },
				{ x = sw + ww*0.99, y = sh + hh },
				{ x = sw + ww*0.05, y = sh + hh }
			}
			render.ClearStencil() --Clear stencil
			render.SetStencilEnable( true ) --Enable stencil
			render.SetStencilWriteMask(1)
			render.SetStencilTestMask(1)
			render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER);
			render.SetStencilFailOperation(STENCILOPERATION_DECR);
			render.SetStencilZFailOperation(STENCILOPERATION_DECR );
			render.SetStencilPassOperation( STENCILOPERATION_DECR ) 
			render.SetStencilReferenceValue( 1 )
			render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_EQUAL )
			surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
			surface.DrawPoly( InfoBarFrame )

end

function MENU:EndStencil()
	render.SetStencilEnable( false )
end