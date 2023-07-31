local ClientResources = 0;
local function ProcessFolder ( Location )
	for k, v in pairs(file.Find(Location .. '*',"GAME")) do
		if !string.find(Location, ".svn") then
			if file.IsDir(Location .. v,"GAME") then
				ProcessFolder(Location .. v .. '/')
			else
				local OurLocation = string.gsub(Location .. v, '../gamemodes/' .. GM.Path .. '/content/', '')
				
				if !string.find(Location, '.db') then			
					ClientResources = ClientResources + 1;
					resource.AddFile(OurLocation);
				end
			end
		end
	end
end

GM.Path = "residentevil2";
--/*
if !game.SinglePlayer() then
	ProcessFolder('gamemodes/' .. GM.Path .. '/content/models/');
	ProcessFolder('gamemodes/' .. GM.Path .. '/content/materials/');
	ProcessFolder('gamemodes/' .. GM.Path .. '/content/sound/');
	ProcessFolder('gamemodes/' .. GM.Path .. '/content/maps/');
end
--*/
