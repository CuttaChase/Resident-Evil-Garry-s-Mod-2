util.AddNetworkString("VoteTransfer")
---------VOTING
local GamemodePath = "re2/rules/gamemode.txt"
local DifficultyPath = "re2/rules/difficulty.txt"
function RecieveDataFromClient(l,ply)
		local VoteMap = net.ReadString()
		local VoteGame = net.ReadString()
		local VoteDifficulty = net.ReadString()
	VotingMaps[tostring(VoteMap)] = VotingMaps[tostring(VoteMap)] + 1
	VotingGamemodes[tostring(VoteGame)] = VotingGamemodes[tostring(VoteGame)] + 1
	VotingDifficulty[tostring(VoteDifficulty)] = VotingDifficulty[tostring(VoteDifficulty)] + 1
	-----
	if VoteDifficulty == "Easy" then
		VotingDifficulty["Easy"] = VotingDifficulty["Easy"] + 1
	elseif VoteDifficulty == "Normal" then
		VotingDifficulty["Normal"] = VotingDifficulty["Normal"] + 1
	elseif VoteDifficulty == "Difficult" then
		VotingDifficulty["Difficult"] = VotingDifficulty["Difficult"] + 1
	elseif VoteDifficulty == "Expert" then
		VotingDifficulty["Expert"] = VotingDifficulty["Expert"] + 1
	elseif VoteDifficulty == "Suicidal" then
		VotingDifficulty["Suicidal"] = VotingDifficulty["Suicidal"] + 1
	end
	-----
	PrintTranslatedMessage(HUD_PRINTTALK,"player_voted_difficulty_on_map_and_mode",ply:Nick(),translate.ClientGet(ply,"difficulty_name_"..string.lower(VoteDifficulty)),VoteMap,translate.ClientGet(ply,"gametype_"..string.lower(VoteGame)))
end
net.Receive("VoteTransfer",RecieveDataFromClient)

function GM:DecideVotes()

	
	local gamemode = "Survivor"
	for a,b in pairs(VotingGamemodes) do 
		if VotingGamemodes[a] > VotingGamemodes[gamemode] && a != gamemode then
			gamemode = tostring(a)
		end
	end
	file.Write(GamemodePath,gamemode)
	
	local difficulty = "Easy"
	for a,b in pairs(VotingDifficulty) do 
		if VotingDifficulty[a] > VotingDifficulty[difficulty] && a != difficulty then
			difficulty = tostring(a)
		end
	end
	file.Write(DifficultyPath,difficulty)
	-------------------------------------------------
	local NewMap = table.Random( MapListTable )
		for a,b in pairs(VotingMaps) do 
			if VotingMaps[a] > VotingMaps[NewMap] && a != NewMap then
				NewMap = tostring(a) 
			end
		end
		for k,v in pairs(EscapeListTable) do
			if NewMap == v then 
				gamemode = "Escape"
				file.Write(GamemodePath,gamemode)
				break					
			end
		end
		for k,v in pairs(BossListTable) do
			if NewMap == v then 
				gamemode = "Boss"
				file.Write(GamemodePath,gamemode)
				break					
			end
		end

	------------------------------
------------------------Escape
---------------------------------------------------------------------------------------------------------
	------------------------------
	

	if (!file.Exists("re2/rules/","DATA")) then
		file.CreateDir("re2/rules/", "DATA")
	end
		
	if NewMap != nil then
	
	timer.Simple(5,function() RunConsoleCommand("changelevel", tostring(NewMap) ) end)
	PrintTranslatedMessage(HUD_PRINTTALK,"changing_map_will_gamemode_on_difficulty",NewMap,translate.ClientGet(ply,"gametype_"..string.lower(gamemode)),translate.ClientGet(ply,"difficulty_name_"..string.lower(difficulty)))
	else
	timer.Simple(10,function() 
	RunConsoleCommand("changelevel", "re2_forest" )
	gamemode = "Survivor"
	end)
	timer.Simple(2,function() 
	PrintTranslatedMessage(HUD_PRINTTALK,"default_map_result") 
	file.Write(FilePath,util.TableToKeyValues(VoteTable))
	end)
	
	end
end
------------------------------------


