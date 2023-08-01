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

local RANKS = {"recruitg1",
"recruitg2",
"recruitg3",
"recruitg4",
"recruitg5",
"apprenticeg1",
"apprenticeg2",
"apprenticeg3",
"apprenticeg4",
"apprenticeg5",
"privateg1",
"privateg2",
"privateg3",
"privateg4",
"privateg5",
"corporalg1",
"corporalg2",
"corporalg3",
"corporalg4",
"corporalg5",
"sergeantg1",
"sergeantg2",
"sergeantg3",
"sergeantg4",
"sergeantg5",
"gunnerysergeantg1",
"gunnerysergeantg2",
"gunnerysergeantg3",
"gunnerysergeantg4",
"gunnerysergeantg5",
"lieutenantg1",
"lieutenantg2",
"lieutenantg3",
"lieutenantg4",
"lieutenantg5",
"captaing1",
"captaing2",
"captaing3",
"captaing4",
"captaing5",
"majorg1",
"majorg2",
"majorg3",
"majorg4",
"majorg5",
"commanderg1",
"commanderg2",
"commanderg3",
"commanderg4",
"commanderg5",
"colonelg1",
"colonelg2",
"colonelg3",
"colonelg4",
"colonelg5",
"brigadierg1",
"brigadierg2",
"brigadierg3",
"brigadierg4",
"brigadierg5",
"generalg1",
"generalg2",
"generalg3",
"generalg4",
"generalg5"}

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

	draw.SimpleText( translate.Format( "skills_player_level_rank_panel", LocalPlayer():GetLevel(), LocalPlayer():GetExp(), math.Round(LocalPlayer():GetExp(2)), translate.Get( "skills_rank_name_" .. RANKS[math.Clamp(LocalPlayer():GetLevel(),1,#RANKS)] ) ), "Default", leftofscreen/0.73, topofscreen+7, Color(255,255,255,255), TEXT_ALIGN_LEFT)

	draw.SimpleText( "+"..exp, "ExpPoints", leftofscreen+prg+2,topofscreen/1.05, Color(35,35,35,(alpha_exp/255)*255), TEXT_ALIGN_CENTER )
	draw.SimpleText( "+"..exp, "ExpPoints", leftofscreen+prg, topofscreen/1.05, Color(255,255,255,(alpha_exp/255)*255), TEXT_ALIGN_CENTER )


	--draw.SimpleText( LocalPlayer():GetPoints(), "Default", ScrW()-50, 82, Color(255,255,255,255), TEXT_ALIGN_RIGHT )

end)