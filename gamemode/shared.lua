GM.Name 		= "Resident Evil"
GM.Author 		= "Cutta Chase Beats"
GM.Email 		= ""
GM.Website 		= ""
GM.TeamBased 	= true



if( SERVER ) then
	AddCSLuaFile( "modules/items.lua" )
	AddCSLuaFile( "sv/sh_ply_extension.lua" )
	AddCSLuaFile( "modules/perks.lua" )
	AddCSLuaFile( "modules/models.lua" )
	AddCSLuaFile( "translate.lua" )
	AddCSLuaFile( "config.lua" )
	AddCSLuaFile( "modules/music.lua" )
end;
include( "modules/items.lua" )
include( "modules/perks.lua" )
include( "modules/models.lua" )
include( "sv/sh_ply_extension.lua" )
include( "translate.lua" )
include( "config.lua" )
include( "modules/music.lua" )
include( "modules/levels.lua" )

function GM:Initialize()
SetGlobalString( "Mode", "Merchant" )
end

function GM:CreateTeams()
	TEAM_SPECTATOR = 0
	team.SetUp(TEAM_SPECTATOR,"Spectator",Color(90,155,90,120))
	team.SetSpawnPoint(TEAM_SPECTATOR,"info_player_start")

	TEAM_HUNK = 1
	team.SetUp(TEAM_HUNK,"Survivors",Color(155,155,155,120))
	team.SetSpawnPoint(TEAM_HUNK,"info_player_start")

	TEAM_CROWS = 2
	team.SetUp(TEAM_CROWS,"Crows",Color(0,155,155,120))
	team.SetSpawnPoint(TEAM_CROWS,"Re2_player_round_start")
end

function GM:LoadNextMap()
	game.LoadNextMap()
end

		-----------------------------------------------------------------------------------------------------------------------------

LeonVoiceLine1 = Sound( "re2_voicelines/leon_v/leon_wholeplaceisgoingdown.mp3" )
LeonVoiceLine2 = Sound( "re2_voicelines/leon_v/leon_dontworryaboutme.mp3" )
AdaVoiceLine1 = Sound( "re2_voicelines/adawong_v/ada_namesada.mp3" )
AdaVoiceLine2 = Sound( "re2_voicelines/adawong_v/ada_dontpushit.mp3" )
AdaVoiceLine3 = Sound( "re2_voicelines/adawong_v/ada_waysclear.mp3" )
HunkVoiceLine1 = Sound( "re2_voicelines/hunk_v/hunk_enemycontact.mp3" )
HunkVoiceLine2 = Sound( "re2_voicelines/hunk_v/hunk_iminjured.mp3" )
HunkVoiceLine3 = Sound( "re2_voicelines/hunk_v/hunk_imreloading.mp3" )
HunkVoiceLine4 = Sound( "re2_voicelines/hunk_v/hunk_targetsdown.mp3" )
HunkVoiceLine5 = Sound( "re2_voicelines/hunk_v/hunk_infectedincoming.mp3" )
ClaireVoiceLine1 = Sound( "re2_voicelines/claire_v/claire_ifoundawayout.mp3" )
ClaireVoiceLine2 = Sound( "re2_voicelines/claire_v/claire_ithinkwecanmakeit.mp3" )

function IncludeModules()

	local folder = string.Replace( GM.Folder, "gamemodes/", "" )

	for c,d in pairs( file.Find( folder.."/gamemode/items/*.lua", "LUA" ) ) do

		if SERVER then
			AddCSLuaFile( folder.."/gamemode/items/"..d )
		end

		include( folder.."/gamemode/items/"..d )

	end

	folder = string.Replace( GM.Folder, "gamemodes/", "" )

	for c,d in pairs( file.Find( folder.."/gamemode/perks/*.lua", "LUA" ) ) do

		if SERVER then
			AddCSLuaFile( folder.."/gamemode/perks/"..d )
		end

		include( folder.."/gamemode/perks/"..d )

	end

	folder = string.Replace( GM.Folder, "gamemodes/", "" )

	for e,f in pairs( file.Find( folder.."/gamemode/models/*.lua", "LUA" ) ) do

		if SERVER then
			AddCSLuaFile( folder.."/gamemode/models/"..f )
		end

		include( folder.."/gamemode/models/"..f )

	end



end
IncludeModules()


model_cache_list = {
	-----Player Models----
	"models/vinrax/player/re2/ada_wong.mdl",
	"models/vinrax/player/re2/leon_normal.mdl",
	"models/vinrax/player/re2/clare_normal.mdl",
	"models/vinrax/player/re2/hunk.mdl",
	-----Zombies------
	"models/nmr_zombie/berny.mdl",
	"models/nmr_zombie/casual_02.mdl",
	"models/nmr_zombie/herby.mdl",
	"models/nmr_zombie/jogger.mdl",
	"models/nmr_zombie/julie.mdl",
	"models/nmr_zombie/toby.mdl",
	"models/player/re/nemesisalpha.mdl",
	"models/player/slow/amberlyn/re5/dog/slow.mdl",
	-----others------
	"models/landmine.mdl",
	"models/chest.mdl",
}


for k, v in pairs (model_cache_list) do
	util.PrecacheModel(v)
end