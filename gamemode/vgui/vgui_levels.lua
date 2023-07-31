local function healthColor()
	if(LocalPlayer():Health() > 75) then
		return Color(54,211,154,200)
	elseif(LocalPlayer():Health() > 50) then
		return Color(241, 196, 15,200)
	elseif(LocalPlayer():Health() > 25) then
		return Color(230, 126, 34,200)
	else
		return Color(231, 76, 60,200)
	end
end

local RANKS = {"Recruit Grade 1",
"Recruit Grade 2",
"Recruit Grade 3",
"Recruit Grade 4",
"Recruit Grade 5",
"Apprentice Grade 1",
"Apprentice Grade 2",
"Apprentice Grade 3",
"Apprentice Grade 4",
"Apprentice Grade 5",
"Private Grade 1",
"Private Grade 2",
"Private Grade 3",
"Private Grade 4",
"Private Grade 5",
"Corporal Grade 1",
"Corporal Grade 2",
"Corporal Grade 3",
"Corporal Grade 4",
"Corporal Grade 5",
"Sergeant Grade 1",
"Sergeant Grade 2",
"Sergeant Grade 3",
"Sergeant Grade 4",
"Sergeant Grade 5",
"Gunnery Sergeant Grade 1",
"Gunnery Sergeant Grade 2",
"Gunnery Sergeant Grade 3",
"Gunnery Sergeant Grade 4",
"Gunnery Sergeant Grade 5",
"Lieutenant Grade 1",
"Lieutenant Grade 2",
"Lieutenant Grade 3",
"Lieutenant Grade 4",
"Lieutenant Grade 5",
"Captain Grade 1",
"Captain Grade 2",
"Captain Grade 3",
"Captain Grade 4",
"Captain Grade 5",
"Major Grade 1",
"Major Grade 2",
"Major Grade 3",
"Major Grade 4",
"Major Grade 5",
"Commander Grade 1",
"Commander Grade 2",
"Commander Grade 3",
"Commander Grade 4",
"Commander Grade 5",
"Colonel Grade 1",
"Colonel Grade 2",
"Colonel Grade 3",
"Colonel Grade 4",
"Colonel Grade 5",
"Brigadier Grade 1",
"Brigadier Grade 2",
"Brigadier Grade 3",
"Brigadier Grade 4",
"Brigadier Grade 5",
"General Grade 1",
"General Grade 2",
"General Grade 3",
"General Grade 4",
"General Grade 5"}

local barExtra = 0

local alpha_exp = 0
local state = 0
local sub = 0
local exp = 0
local timeout = 0

net.Receive("DR_Experienced",function(l,ply)
	state = 1
	sub = 3
	
	if(timeout <= CurTime()) then
		exp = net.ReadFloat()
	else
		exp = exp + net.ReadFloat()
	end

	timeout = CurTime() + 2
end)

hook.Add("HUDPaint","DrawDRHUD",function()

	--XP ZONE

	local offset = ScrW()/1.51
	local offsetY = ScrH()/8 + 20
	local leftofscreen, topofscreen = ScrW()-offset, ScrH()-(offsetY/3.6)

	local prg = (leftofscreen)*LocalPlayer():GetExp(1)

	if(state == 0) then
		alpha_exp  = Lerp(FrameTime(),alpha_exp,-1)
	end

	if(state == 1 && alpha_exp < 255) then
		alpha_exp = Lerp(FrameTime(),alpha_exp,256)
	elseif(state == 1) then
		state = 2
	end

	if(sub > 0) then
		sub = sub - FrameTime()
	else
		state = 0
	end

	
	




		
	surface.SetDrawColor(45,45,45,175)
	surface.DrawRect(leftofscreen,topofscreen,leftofscreen,36)

	local clr = LocalPlayer():GetLevelColor()

	surface.SetDrawColor(Color(clr.r,clr.g,clr.b,50))
	surface.DrawRect(leftofscreen,topofscreen+3,prg,28)

	surface.SetDrawColor(Color(clr.r,clr.g,clr.b,50))
	surface.DrawRect(leftofscreen,topofscreen+3,prg,4)

	draw.SimpleText( "Level: "..LocalPlayer():GetLevel().. "  "..LocalPlayer():GetExp().."/"..math.Round(LocalPlayer():GetExp(2)).." - "..RANKS[math.Clamp(LocalPlayer():GetLevel(),1,#RANKS)], "Default", leftofscreen/0.73, topofscreen+7, Color(255,255,255,255), TEXT_ALIGN_LEFT)

	draw.SimpleText( "+"..exp, "ExpPoints", leftofscreen+prg+2,topofscreen/1.05, Color(35,35,35,(alpha_exp/255)*255), TEXT_ALIGN_CENTER )
	draw.SimpleText( "+"..exp, "ExpPoints", leftofscreen+prg, topofscreen/1.05, Color(255,255,255,(alpha_exp/255)*255), TEXT_ALIGN_CENTER )


	--draw.SimpleText( LocalPlayer():GetPoints(), "Default", ScrW()-50, 82, Color(255,255,255,255), TEXT_ALIGN_RIGHT )

end)