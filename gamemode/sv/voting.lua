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
	print(VotingMaps[tostring(VoteMap)])
	print(VoteMap)
	-----
	PrintTranslatedMessage(HUD_PRINTTALK,"player_voted_difficulty_on_map_and_mode",ply:Nick(),translate.ClientGet(ply,"difficulty_name_"..string.lower(VoteDifficulty)),VoteMap,translate.ClientGet(ply,"gametype_"..string.lower(VoteGame)))
	print(ply:Nick().." Voted "..VoteDifficulty.." on "..VoteMap.." and gamemode "..VoteGame)
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
	

	----Define Player
	local players = player.GetAll()
	for i = 1, #players do

		local ply = players[i]

		if (!file.Exists("re2/rules/","DATA")) then
			file.CreateDir("re2/rules/", "DATA")
		end

		if NewMap != nil then
		
			timer.Simple(5,function() 
				RunConsoleCommand("changelevel", tostring(NewMap) ) 
			end)
			PrintTranslatedMessage(HUD_PRINTTALK,"changing_map_will_gamemode_on_difficulty",NewMap,translate.ClientGet(ply,"gametype_"..string.lower(gamemode)),translate.ClientGet(ply,"difficulty_name_"..string.lower(difficulty)))
			print("Changing to "..NewMap.." in 5 seconds. The gamemode will be "..gamemode.." On "..difficulty)
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
end
------------------------------------


