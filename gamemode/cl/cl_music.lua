
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

net.Receive("RE2_MakeTrack", function()
	local s = net.ReadString()
	Sound_StopTrack()
	Sound_Create(s)


end)

net.Receive("RE2_MakeTrack2", function()
	local s = net.ReadString()
	Sound_StopTrack()
	Sound_Create(s)



end)

net.Receive("RE2_MakeTrack3", function()
	local s = net.ReadString()
	Sound_StopTrack()
	
	Sound_Create(s)


end)


function Sound_StopTrack()
	local pl = LocalPlayer()
	if !pl:IsValid() then
		if Sound_GlobalMusic.Sound == nil || !Sound_GlobalMusic.Sound:IsPlaying() then return end
		Sound_GlobalMusic.Sound:Stop()
		Sound_GlobalMusic.Sound:ChangeVolume(0)
	end
	Sound_GlobalMusic.Sound:Stop()
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
	timer.Simple(120, function() if Sound_GlobalMusic.Path == Sound then Sound_PlayTrack(Length,Sound) end end)


end