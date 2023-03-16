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
end;
include( "modules/items.lua" )
include( "modules/perks.lua" )
include( "modules/models.lua" )
include( "sv/sh_ply_extension.lua" )
include( "translate.lua" )
include( "config.lua" )

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

LIGHT_COMMANDS = {
	"Kick",
	"Msg",
	"Slap",
}
COMMANDS = {
	"Kick",
	"Ban",
	"Slay",
	"Slap",
	"Freeze",
	"UnFreeze",
	"StripWeapons",
	"Break Legs",
	"Suicide Bomb",
	"Msg",
	"SetJump",
	"Ignite",
	"SetHealth",
	"Give",
}
SUPER_COMMANDS = {
	"Kick",
	"Ban",
	"Slay",
	"Slap",
	"Freeze",
	"UnFreeze",
	"Give",
	"Godmode",
	"UnGodmode",
	"Toggle/NoClip",
	"StripWeapons",
	"Break Legs",
	"Suicide Bomb",
	"Msg",
	"SetJump",
	"Ignite",
	"SetHealth",
	"Create",
	"AdminGiveItemPlayer",
}

LeonVoiceLine1 = Sound( "re2_voicelines/leon_v/leon_wholeplaceisgoingdown.mp3" )
LeonVoiceLine2 = Sound( "re2_voicelines/leon_v/leon_dontworryaboutme.mp3" )
AdaVoiceLine1 = Sound( "re2_voicelines/adawong_v/ada_namesada.mp3" )
AdaVoiceLine2 = Sound( "re2_voicelines/adawong_v/ada_dontpushit.mp3" )
AdaVoiceLine3 = Sound( "re2_voicelines/adawong_v/ada_waysclear.mp3" )

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
	"models/vinrax/player/re2/ada_wong.mdl",
	"models/vinrax/player/re2/leon_normal.mdl"

}
for k, v in pairs (model_cache_list) do
	util.PrecacheModel(v)
end