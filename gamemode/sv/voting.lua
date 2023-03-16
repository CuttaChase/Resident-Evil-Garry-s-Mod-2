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
	PrintMessage(HUD_PRINTTALK,ply:Nick().." Voted "..VoteDifficulty.." on "..VoteMap.." and gamemode "..VoteGame)
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
	PrintMessage(HUD_PRINTTALK,"Changing to "..NewMap.." in 5 seconds. The gamemode will be "..gamemode.." On "..difficulty)
	else
	timer.Simple(10,function() 
	RunConsoleCommand("changelevel", "re2_forest" )
	gamemode = "Survivor"
	end)
	timer.Simple(2,function() 
	PrintMessage(HUD_PRINTTALK,"Default Map Choice Because No One Voted") 
	file.Write(FilePath,util.TableToKeyValues(VoteTable))
	end)
	
	end
end
------------------------------------


