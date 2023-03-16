----------------Admin Stuff

util.AddNetworkString("PauseTimer")
util.AddNetworkString("UnPauseTimer")
util.AddNetworkString("SetMoney")
util.AddNetworkString("CreateWeapon")
util.AddNetworkString("CreateItem")
util.AddNetworkString("SetDifficulty")
util.AddNetworkString("SetMode")
util.AddNetworkString("fixPlayer")
util.AddNetworkString("fixPlayerall")

function PauseTimer()
  timer.Pause("Re2_CountDowntimer_Survivor")
  timer.Pause("Re2_CountDowntimer")
    if CLIENT then
      timer.Pause("Re2_CountDowntimer_Survivor")
      timer.Pause("Re2_CountDowntimer")
    end
end

function UnPauseTimer()
  timer.UnPause("Re2_CountDowntimer_Survivor")
  timer.UnPause("Re2_CountDowntimer")
    if CLIENT then
      timer.UnPause("Re2_CountDowntimer_Survivor")
      timer.UnPause("Re2_CountDowntimer")
    end
end

function SetPlayerMoney()
  PlayerID = net.ReadString(name)
  moneyRecieved = net.ReadString(money)
  newMoney = tonumber(moneyRecieved)

  for k, v in pairs( player.GetAll() ) do
	 foundID = v:SteamID()
   if PlayerID == foundID then
     v:SetNWInt("Money",newMoney)
     v:ChatPrint("Your money has been set to: "..newMoney)
     print("Saved "..v:Name().." money.")
   end
 end
end

function CreateItem()
  creatorpos = net.ReadVector(playerPos)
  selecteditem = net.ReadString(iname)
				local item = ents.Create(selecteditem)
        print(selecteditem)
				item:SetPos(creatorpos)
				item:Spawn()
				if item:GetPhysicsObject():IsValid() then
					item:GetPhysicsObject():ApplyForceCenter(Vector(0,0,10))
				end
end

function CreateWeapon()
  weapon = net.ReadString(wname)
  creatorpos = net.ReadVector(playerPos)
	local item = ents.Create(weapon)
	item:SetPos(creatorpos)
	item:Spawn()
end

function SetDifficulty()
  reqestedDifficulty = net.ReadString(difficulty)
  SetGlobalString("RE2_Difficulty",reqestedDifficulty)
    for k,v in pairs(player.GetAll()) do
      v:ChatPrint("Gamemode Difficulty has been set to: "..reqestedDifficulty)
    end
end

function SetGM()
  reqestedMode = net.ReadString(GameMode)
  SetGlobalString("RE2_Game",reqestedMode)
    for k,v in pairs(player.GetAll()) do
      v:ChatPrint("Gamemode has been set to: "..reqestedMode)
    end
end

function fixPlayer()
  reqestedSID = net.ReadString(pname)

  for k, v in pairs( player.GetAll() ) do
    foundID = v:Name()
    if reqestedSID == foundID then
      v:SetHealth(100)
      v:SetNWBool("Infected", false)
      v:SetNWInt("InfectedPercent", 0)
      v:SetNWInt("Immunity", v:GetNWInt("Immunity") + 10 )
      v:ChatPrint("You have been healed/cured.")
    end
end

end

net.Receive("PauseTimer", function() PauseTimer() end)
net.Receive("UnPauseTimer", function() UnPauseTimer() end)
net.Receive("SetMoney",function() SetPlayerMoney() end)
net.Receive("CreateWeapon",function() CreateWeapon() end)
net.Receive("CreateItem",function() CreateItem() end)
net.Receive("SetDifficulty",function() SetDifficulty() end)
net.Receive("fixPlayer",function() fixPlayer() end)
net.Receive("fixPlayerall",function()
  for k, v in pairs( player.GetAll() ) do
    if v:Team() != TEAM_CROWS then
      v:SetHealth(100)
      v:SetNWBool("Infected", false)
      v:SetNWInt("InfectedPercent", 0)
      v:SetNWInt("Immunity", v:GetNWInt("Immunity") + 10 )
      v:ChatPrint("All players have been healed.")
    else
    print("Crows TRue") end
  end
end)
net.Receive("SetMode",function() SetGM() end)
