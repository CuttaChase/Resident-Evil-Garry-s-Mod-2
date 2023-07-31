function GM:EstablishRules()

	local GamemodePath = "re2/rules/gamemode.txt"
	local DifficultyPath = "re2/rules/difficulty.txt"
	if file.Exists(GamemodePath, "DATA") && file.Exists(DifficultyPath, "DATA")  then
		local difficulty = file.Read(DifficultyPath,"DATA")
		local gamemode = file.Read(GamemodePath,"DATA")
		SetGlobalString("Re2_Difficulty",tostring(difficulty))

		local NewGamemode = gamemode
			if GAMEMODE.Gamemode[NewGamemode] != nil then
				SetGlobalString( "RE2_Game", NewGamemode)
			else
				local chance = math.random(1,3)
				if chance == 1 then
					SetGlobalString( "RE2_Game", "Survivor" )
				elseif chance == 2 then
					SetGlobalString( "RE2_Game", "VIP" )
				elseif chance == 3 then
					SetGlobalString( "RE2_Game", "Mercenaries" )
				end
			end
	else

		SetGlobalString("Re2_Difficulty","Normal")

		local chance = math.random(1,3)
		if chance == 1 then
			SetGlobalString( "RE2_Game", "Survivor" )
		elseif chance == 2 then
			SetGlobalString( "RE2_Game", "VIP" )
		elseif chance == 3 then
			SetGlobalString( "RE2_Game", "Mercenaries" )
		end
	end

end

function GM:BasePrep()
	GAMEMODE:EstablishRules()
	local merchtime = GAMEMODE.Config.MerchantTime
	SetGlobalInt("Re2_CountDown", merchtime)
	SetGlobalString( "Mode", "Merchant" )

	GAMEMODE:SelectMusic(GetGlobalString("Mode"))

	timer.Create("Re2_CountDowntimer",1,0, function()
		SetGlobalInt("Re2_CountDown", GetGlobalInt("Re2_CountDown") - 1)
		if GetGlobalInt("Re2_CountDown") <= 0 then
			if GAMEMODE.Gamemode[GetGlobalString("Re2_Game")].Condition != nil then
				if !GAMEMODE.Gamemode[GetGlobalString("Re2_Game")].Condition() then
					SetGlobalString("Re2_Game","Survivor")
				PrintTranslatedMessage(HUD_PRINTTALK, "not_enough_players")
				end
			end
			if GAMEMODE.Gamemode[GetGlobalString("RE2_Game")].PrepFunction() != nil then
				GAMEMODE.Gamemode[GetGlobalString("RE2_Game")].PrepFunction()
			end
			for _,entity in pairs(ents.FindByName("RE2_Round_Merchant_End")) do
				if entity:IsValid() && entity != nil then
					entity:Fire( "Trigger" )
				end
			end
			for k,v in pairs(player.GetAll()) do
				for _,spawnpoint in pairs(ents.FindByClass("Re2_player_round_start")) do
					if !spawnpoint.Taken then
						v:SetPos(spawnpoint:GetPos())
						spawnpoint.Taken = true
						break
					end
				end
			end
			timer.Destroy("Re2_CountDowntimer")
		end
	end)

end

function GM:BaseStart()
	GAMEMODE:GamemodeStart()
	GAMEMODE:GameCheck()
	isInRound = true
	SetGlobalString( "Mode", "On" )
	GAMEMODE:SelectMusic(GetGlobalString("Mode"))

	--------Voice Actors Lines Audio------------------
	for _, leon in pairs(ents.GetAll()) do
		if leon:IsPlayer() && leon.EquippedModel == "leon" then
			sound.Play( LeonVoiceLine1, leon:GetPos() )
			if GetGlobalString("RE2_Game") == "Escape" then
				sound.Play( LeonVoiceLine2, leon:GetPos() )
			end
		end
	end

	for _, hunk in pairs(ents.GetAll()) do
		if hunk:IsPlayer() && hunk.EquippedModel == "hunk" then
			sound.Play( HunkVoiceLine5, hunk:GetPos() )
			if GetGlobalString("RE2_Game") == "Escape" then
				sound.Play( HunkVoiceLine1, hunk:GetPos() )
			end
		end
	end
	--------------------------------------------------
	local zombietime = GAMEMODE.Config.ZombieSpawnTime - GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier
	if (GetGlobalString("RE2_Game") == "Boss") then
		timer.Create("SpawningZombies2",zombietime,0, function() GAMEMODE:SpawningZombies2() end )
	else
		timer.Create("SpawningZombies",zombietime,0, function() GAMEMODE:SpawningZombies() end )
	end
	---- map Triggers
	for _,entity in pairs(ents.FindByName("RE2_Round_Start")) do
		if entity:IsValid() && entity != nil then
			entity:Fire( "Trigger" )
		end
	end
end

function GM:BaseEndGame()
	--if 1 == 1 then return end
	if GetGlobalString("Mode") == "End" then return end

	GAMEMODE:GamemodeEnd()
	-------Remove Perks When Gamemode Ends
	local endingtime = GAMEMODE.Config.VotingTime
	SetGlobalString( "Mode", "End" )
	GAMEMODE:SelectMusic(GetGlobalString("Mode"))


	--------Voice Actors Lines Audio------------------
	for _, ada in pairs(ents.GetAll()) do
		if ada:IsPlayer() && ada.EquippedModel == "adawong" && ada:Team() == TEAM_HUNK then
			sound.Play( AdaVoiceLine3, ada:GetPos() )
		end
	end	
	for _, hunk in pairs(ents.GetAll()) do
		if hunk:IsPlayer() && hunk.EquippedModel == "hunk" && hunk:Team() == TEAM_HUNK then
			sound.Play( HunkVoiceLine4, hunk:GetPos() )
		end
	end	
	--------------------------------------------------
	timer.Simple(3,function()
		for _,ply in pairs(player.GetAll()) do
			timer.Simple(2, function() GAMEMODE:ShowSpare2( ply )
			 end)
			Save(ply)
		end
	end)
	timer.Simple(endingtime,function()
		for _,ply in pairs(player.GetAll()) do
			Save(ply)
		end
		GAMEMODE:DecideVotes()
	end)
end


function GM:GameCheck()
	if GetGlobalString("Mode") == "End" then return end

	GAMEMODE.Gamemode[GetGlobalString("RE2_Game")].CheckFunction()

end

function GM:GamemodeStart()

	GAMEMODE.Gamemode[GetGlobalString("RE2_Game")].StartFunction()

end

function GM:GamemodeEnd()

	GAMEMODE.Gamemode[GetGlobalString("RE2_Game")].EndFunction()
	GAMEMODE.Gamemode[GetGlobalString("RE2_Game")].RewardFunction()

end


















------------------------------------------
--------------------------------------------
------------------------------------------
------------------------------------------
------------------------------------------
--------------------------------------------
------------------------------------------
------------------------------------------
------------------------------------------
--------------------------------------------
------------------------------------------
------------------------------------------
------------------------------------------
--------------------------------------------
------------------------------------------
------------------------------------------
------------------------------------------
--------------------------------------------
------------------------------------------
------------------------------------------
------------------------------------------
--------------------------------------------
------------------------------------------
------------------------------------------
------------------------------------------
--------------------------------------------
------------------------------------------
------------------------------------------
------------------------------------------
--------------------------------------------
------------------------------------------
------------------------------------------




























