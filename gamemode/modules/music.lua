if SERVER then
	util.AddNetworkString( "RE2_MakeTrack" )
	util.AddNetworkString( "RE2_MakeTrack2" )
	util.AddNetworkString( "RE2_MakeTrack3" )
	util.AddNetworkString( "RE2_SpawnTrack" )







	function GM:SelectMusic(Mode)
		if GetGlobalString("Mode") == "Merchant" or GetGlobalString("Mode") == "prep" then
			local musicsafe = table.Random(GAMEMODE.Music.Safe).Sound
			if SERVER then
				for _,ply in pairs(player.GetAll()) do
					net.Start("RE2_MakeTrack")
					net.WriteString(musicsafe)
					net.Send( ply )
				end
			end
		elseif GetGlobalString("Mode")  == "On" then
			local musicbattle = table.Random(GAMEMODE.Music.Battle).Sound
			if SERVER then
				for _,ply in pairs(player.GetAll()) do
					net.Start("RE2_MakeTrack2")
					net.WriteString(musicbattle)
					net.Send( ply )
				end
			end
		elseif GetGlobalString("Mode")  == "End" then
			local musicend = table.Random(GAMEMODE.Music.End).Sound
			if SERVER then
				for _,ply in pairs(player.GetAll()) do
					net.Start("RE2_MakeTrack3")
					net.WriteString(musicend)
					net.Send( ply )
				end
			end
		end
	end

end


if CLIENT then	



	function Sound_Create(InputTrack)

		pl = LocalPlayer()
		if Sound_GlobalMusic == nil then
			Sound_GlobalMusic = {}
		end
		Sound_GlobalMusic.Sound = CreateSound(pl,InputTrack)
		Sound_GlobalMusic.Path = InputTrack	
		if GetConVar("cl_regmod_enablemusic"):GetBool(1) then
		Sound_GlobalMusic.Sound:Play()
		end


		print(Sound_GlobalMusic.Path)
			for k,v in pairs(GAMEMODE.Music.Safe) do
				if v.Sound == InputTrack  then
					timer.Simple(v.Length, function() if Sound_GlobalMusic.Path == v.Sound  then  Sound_PlayTrack(v.Length,v.Sound) end end)
					break
				end
			end
			for k,v in pairs(GAMEMODE.Music.Battle) do
				if v.Sound == InputTrack then
					timer.Simple(v.Length, function() if Sound_GlobalMusic.Path == v.Sound then Sound_PlayTrack(v.Length,v.Sound) end end)
					break
				end
			end
			for k,v in pairs(GAMEMODE.Music.End) do
				if v.Sound == InputTrack then
					timer.Simple(v.Length, function() if Sound_GlobalMusic.Path == v.Sound then Sound_PlayTrack(v.Length,v.Sound) end end)
					break
				end
			end

	end

	




	function Sound_StopTrack()
		local pl = LocalPlayer()
		if pl:IsValid() then
			if Sound_GlobalMusic.Sound == nil || !Sound_GlobalMusic.Sound:IsPlaying() then return end
			Sound_GlobalMusic.Sound:Stop()
			Sound_GlobalMusic.Sound:ChangeVolume(0)
		end
		--Sound_GlobalMusic.Sound:Stop()
	end




	function Sound_PlayTrack(Length,Sound)


		if Sound_GlobalMusic.Sound == nil then return end
		local pl = LocalPlayer()
		if pl:IsValid() then
			if Sound_GlobalMusic.Sound:IsPlaying() then
				Sound_GlobalMusic.Sound:Stop()
			end
		end
		Sound_GlobalMusic.Sound:Play()
		if GetConVar("cl_regmod_enablemusic"):GetBool(1) then
			timer.Simple(Length, function() if Sound_GlobalMusic.Path == Sound then Sound_PlayTrack(Length,Sound) end end)
		end


	end



	net.Receive("RE2_MakeTrack", function()
		local s = net.ReadString()
		local music = net.ReadString()

		Sound_StopTrack()
		Sound_Create(s, music)



	end)

	net.Receive("RE2_MakeTrack2", function()
		local s = net.ReadString()
		local music = net.ReadString()
		Sound_StopTrack()
		Sound_Create(s, music)



	end)

	net.Receive("RE2_MakeTrack3", function()
		local s = net.ReadString()
		local music = net.ReadString()
		Sound_StopTrack()
		Sound_Create(s, music)


	end)


end